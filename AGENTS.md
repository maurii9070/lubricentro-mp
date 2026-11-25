# AGENTS.md

Monorepo `lubricentro-mp`: backend Spring Boot en `/backend` + PostgreSQL por Podman. Repositorio recién inicializado (sin commits todavía), por lo que aún no hay capas implementadas ni migraciones.

## Stack verificado

- Java 21 (JDK 21), Spring Boot **4.2.0**, Maven Wrapper (Maven 3.10.1).
- Dependencias: Spring Data JPA, Flyway (`flyway-database-postgresql`), Validation, Spring MVC, Lombok, driver PostgreSQL.
- PostgreSQL **18** (`postgres:18-alpine`) en `compose.yaml`, base `lubricentro_mp`, usuario `dev_user` / `dev_password`, puerto host `5432`.
- Paquete base `com.lubricentromp.api`; app `lubricentro-mp-api`; puerto `8080`.

## Comandos

Ejecutar Maven desde `/backend`, no desde la raíz.

```bash
podman compose up -d postgres        # desde la raíz del repo
cd backend
./mvnw spring-boot:run
./mvnw test
./mvnw test -Dtest=BackendApplicationTests          # una clase
./mvnw test -Dtest=BackendApplicationTests#contextLoads  # un método
./mvnw clean package
```

Configuración por variables de entorno: `DB_URL`, `DB_USER`, `DB_PASSWORD`, `SHOW_SQL`, `PORT`, `EXCEL_PATH` (default `../data/STOCK_MP_ESCRITORIO.xlsx`, relativo a `backend/`; ese directorio no está en el repo).

## Convenciones obligatorias

1. **Código y base de datos en inglés**: clases, métodos, variables, DTOs, enums, paquetes, tablas, columnas, índices y nombres de scripts Flyway.
2. **Textos hacia el usuario en español**: mensajes de error y de validación (`@NotNull(message = "...")`), documentación y seed data.
3. **Arquitectura en capas**: `controller`, `service`, `repository`, `entity`, `dto`, `mapper`, `exception`, `enums`. La lógica transaccional y el `@Transactional` van en `service`. Requests y responses son `record` inmutables, nunca entidades expuestas en controllers.
4. **Mappers manuales** (sin MapStruct ni mapeo en controllers): clases sin estado en el paquete `mapper`, anotadas con `@Component` e inyectadas por constructor en el service. Métodos `toEntity(...)` / `toResponse(...)`; el mapeo entidad → DTO ocurre dentro de la transacción del service para no tocar relaciones lazy.
5. **Flyway es la única fuente del esquema**: `ddl-auto: validate`, así que cada entidad/columna debe existir en una migración o la app no arranca. Nunca editar una migración ya ejecutada: crear una nueva versión incremental (`V2__...sql`, etc.) en `src/main/resources/db/migration`.
6. **Infraestructura con Podman**: todo el entorno de contenedores utiliza **Podman** (`podman compose`, `podman ps`, `podman exec`) en reemplazo de Docker.

## Trampas del entorno

- `spring.jpa.open-in-view: false`: las relaciones lazy deben resolverse dentro del método `@Transactional` del service y mapearse a DTO antes de salir de la capa.
- La imagen de PostgreSQL 18 monta el volumen en `/var/lib/postgresql` (no `/var/lib/postgresql/data`). Es intencional; no "corregirlo".
- Spring Boot 4 usa `spring-boot-starter-webmvc` (no `-web`) y starters de test por módulo (`spring-boot-starter-*-test`). No renombrar ni bajar versiones.
- `.idea/` está en `.gitignore`; no commitear archivos del IDE.
