-- V13: carga inicial del padrón de vehículos y su historial de services.
-- Origen: hoja 'CLIENTES 2026' de 'STOCK MP ESCRITORIO .xlsx'.
--
-- Filas leídas: 243. Filas con patente: 235. Filas sin patente omitidas: 8.
-- Vehículos únicos (patente normalizada sin espacios ni guiones): 215.
-- Services históricos: 235 ventas con tipo SERVICE, sin impacto en caja ni en stock.
-- Los importes históricos se cargan en 0.00 y no se generan movimientos de stock.
--
-- Criterios aplicados:
--   * operation_date: FECHA SER. La fila 122 corrige el typo 16/6/20026 -> 2026-06-16.
--   * La fila 207 corrige 1900-01-15 (error de tipeo en Excel) -> 2026-09-15.
--   * Las fechas nulas se cargan como 2026-01-01 00:00:00.
--   * mileage: KM ACTUAL entero; textos como CONFI o SIN MARCA quedan en NULL.
--   * technical_notes: "Próximo service: N km" más las observaciones de la fila.
--   * sale_details: filtros y aceite como renglones descriptivos sin producto asociado.
--

-- ============================================================
-- Vehículos (215 registros)
-- ============================================================

INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA030NL', 'AMAROK 2,0', 'JONAS', '3884149410');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA062IW', 'VW FOX', 'GUIDO', '3884209549');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA105RV', 'F UNO S1,4', 'NICOLAS (OTRO AUTO)', '3883321420');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA107HJ', 'ECOSPORT KINETIC 1,6 2016', 'VALERIA', '3884702310');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA133CH', 'AMAROK APPACE', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA134EJ', 'FIESTA 1,6', 'MARIA (VALDIVIEZO)', '3885859473');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA379IW', 'PRISMA 1,4', 'CARLOS ROSALES', '3885303911');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA390IN', 'KANGOO 1,6', 'OSCAR CRESPO', '3885009903');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA402WE', 'CLIO RENAUL', 'LILIANA (TOLABA)', '3886023833');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA416DB', 'TIGGO 3 1,6', 'NICOLAS', '1125802842');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA432FJ', 'PUNTO 1,6', 'BRENDA', '3885133752');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA574PM', 'PALIO 1,4', 'JORGE', '3884695858');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA679EL', 'LOGAN 1,6', 'UBER', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA848XN', 'KANGOO 1,5', NULL, '3886527174');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA856UJ', 'FRONTIER N 2,3', 'MARTIN (KIOSKO)', '3884108179');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA873JH', 'FIAT TORO', 'JORGE RIPOLL', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AA926TE', 'ECOSPORT2,0', 'ARJONA (VITAL)', '3884075879');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB053OQ', 'SURAN 1,6 2017', 'BIZZOTTO (BRUNO)', '3884688423');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB093FW', 'FIORINO1,4', 'EZEQUIEL LOPEZ', '3885392255');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB196JD', 'HILUX 4X4', 'ABRAM (BENAVIDEZ)', '3435046901');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB244GZ', 'HILUX 2017', 'JOSE', '3885105119');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB249VV', 'TORO 2,0 D', 'AGUSTINA', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB249XN', 'ETIOS TOYOTA', 'FABRICIO', '3885106548');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB375WW', 'W GOLF 2017 1,6', 'CARRASCOS (IRIS)', '3888664056');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB385WN', 'CRUZE 1,4T', 'FERNANDO', '3884969120');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB482YZ', 'C4 LOUNGE', 'RODRIGO (CASTRO)', '3884843983');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB490NK', 'FIAT RANGER 2,2', 'JORGE', '3885014037');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB550EO', '408 HDI', 'DANIEL BLASCO', '3884073858');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB602IB', 'LOGAN', 'ALBERTO (TAXIS)', '3884130662');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB639UR', 'GOL 1,6', 'LEOPOLDO (BURGOS)', '3884177192');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB712MK', 'PALIO 1,4', 'MATIAS (TOLABA)', '3884211368');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB762PE', 'VW GOL', 'VICTOR COLQUI', '3884585266');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB762QU', 'PEUGEOT 208 1,6', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB762RW', 'VOLKSWAGEN FOX MSI 2017', 'FEDERICO (PORTAL)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB898IP', 'ECO DRAGON', 'RAUL (MELO)', '3884083175');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB898KI', 'CITROEN C4', 'JUAN (JEREZ)', '3885044793');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB953UT', 'TRACKER 1,8', 'MARIO (FARFAN)', '3885473953');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AB980KF', 'FIIORINO', 'EDGARDO (TRABAJO)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC032CE', 'S10 2,8', 'ELBER (RIOS)', '3886655602');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC043VB', 'UP 1,0 2017', 'GUERRERO (GABRIEL)', '3885108741');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC080CJ', 'SIENA 1,4', 'NORMANDO (PERALES)', '3562546285');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC086XY', 'ECO2017', 'WILFREDO', '2966657003');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC122UP', 'peugeot 2008', 'FERNANDO (MARISCAL)', '3886860952');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC157TX', 'GOL 1,6', 'LUIS DAZA (COCO)', '3885839146');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC158JE', 'CRUZE 1,4T', 'FRANCO (MAMANI)', '3884649169');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC256BF', 'FORD KA 2018 1,5', 'MARTIN (GROSSO)', '3885986712');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC256BW', 'ARGO 1,3', 'ALEJANDRO (AXION)', '3884703549');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC404CN', 'FIAT TORO 1,8 2019', 'DANIEL NIEVES', '3884130403');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC511NY', 'VIRTUS1,6', 'SEBA (VENTAS)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC587BR', 'VW SURAN 1,6', 'RODOLFO (DOMINGUEZ)', '3884582741');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC592LQ', 'VW VIRTUS', 'MAURO (LOPEZ)', '3883508650');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AC844QR', 'ARGO1,8', 'DAVID CAMPOS', '3888511032');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD023TQ', '308 HDI 1,6', 'AGUSTIN', '3884209424');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD056BM', 'FORD FOCUS', 'BRAVO (OMAR)', '3884126760');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD111IY', 'VW POLO', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD123BT', '408 1,6 thp', 'ALBERTO CORIA', '3884976904');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD284LW', 'suran 1,6 n', 'FRANCO (MAMANI)', '3885887667');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD386LS', 'OROCH 2,0', 'KWID', '3884880580');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD464RA', 'FORD FIESTA 1,6 2019', 'MARIA INES (VEGA)', '3884081343');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD574FR', 'CRONOS 1,3', 'WALTER (IBARRA)', '3885019837');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD616', 'FIAT TORO 1,8 2019', 'JONATAN', '3884872245');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD686IL', 'ONIX JOY 1,4 2019', 'DANIEL (VILLALOBO)', '3884725925');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD702RZ', 'POLO 1,6', 'DAVID', '3884660719');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD708AY', 'AMAROK 2019', 'DIEGO (CRUZ)', '3884772434');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD748MV', 'C3 1,5', 'ARMANDO', '3885042953');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD800OB', 'OROCH 2,0', 'BENJAMIN VECINO (TUNAY)', '3884747002');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AD951AE', 'ARGO 1,3', 'FERNANDO', '2215464826');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE044DA', 'STRADA 1,4', NULL, '3884631993');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE056SZ', 'peugeot 208', 'NATALIA', '3884875819');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE172FV', 'SANDERO 1,6', 'EDUARDO (FIORINO)', '3886350838');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE225XF', 'LOGAN 1,6', 'FRANCISCO PEREA', '3885851024');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE250VD', 'SANDERO 1,6', 'GUILLERMO (ACOSTA)', '3884165203');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE269YN', 'FORD KA', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE342WI', 'STRADA 1,4', 'DARIO QUIROZ', '3884085406');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE487DR', 'GOL', 'WALTER (VEDIA)', '3885703204');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE552WQ', 'HILUX 2021 2,4', 'JESUS (ALANCAY)', '3884631993');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE582LI', 'VW GOL TREND 1,6', 'JOSE (LOPEZ TAXI)', '3885727427');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE618AU', 'TRACKER 1,2', 'RAUL LEONES', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE618AX', 'CRONOS 1,3', 'ALEJO (SOLIS)', '3888538603');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE619VT', 'GOL 1,6', 'GUSTAVO (LOPEZ)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE689TZ', 'DUSTER1,6', 'FELIX', '3883331674');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE695BB', 'JEEP 1,8', 'ALDO (FLORES)', '3885885009');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AE970BO', 'HILUX', 'CARLOS CALVO', '3884121049');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF291YE', 'KANGOO 2022 1,6 NAFTERA', 'CALPANCHAY (JOSE LUIS)', '3884632550');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF365CP', 'C4 CACTUS', 'LUIS PAREDES', '3884338335');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF452YN', 'KANGOO 1,6', 'MARTA (TERANMAN)', '3884792996');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF455QR', 'POLO 1,6 2022', 'MAMANI (JORGE)', '3884695858');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF502TA', 'RENAULT LOGAN', 'EDUARDO (RILOBA)', '3884178535');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF534JR', 'VOLKSWAGEN POLO 1,6 2023', 'ALAN', '3884778334');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF558HD', 'CRONOS 1,3 REMIS DE TILCARA', 'CRISTIAN (CARRAZANA)', '3884089527');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF602IB', 'RENAULT LOGAN', 'ALBERTO (QUIPILDOR)', '3884130662');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF660KK', 'ETIOS 1,5', 'NESTOR', '3884544672');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF720XH', 'JEEP 1,8 N', 'ELSA MARTINEZ', '3884714187');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF757QZ', 'logan 1,6', 'GUSTAVO (REMIS)', '3885125511');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF789RW', 'TORO 2,0 D', 'SEBASTIAN (VENTA)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF817OK', 'AMAROK V6', 'SEBA (VENTA OK)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF824HG', 'ALASKAN', 'ISAC GARAY', '3884631804');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF8580TD', '208 1,6', 'ENRIQUE (FLORES)', '3884633642');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AF902ZS', 'amarok', 'MAURICIO', '3884336157');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AG', 'COROLLA HYBR1,6', 'GRACIELA (CASTRO)', '3884375313');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AG152SF', 'CRONOS 1,3', 'CAROLINA', '3885055679');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AG181XO', 'CRONOS 1,3', 'JOSEFINA', '3884631671');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AG239IB', 'CRONOS 1,3 2023', 'ALEMAN (ANDRES)', '3884049261');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AG239MB', 'FORD KANGOO 1,5 DCI 2023', 'GUILLERMO (MIRANDA)', '3885904442');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AG256FN', 'CRONOS 1,3', 'DANIEL (VARGAS)', '3884154520');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AG568HJ', 'CRONOS 1,3', NULL, '3884174379');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AG990TT', 'KANGOO 1,5', 'JUAN (TAXIS)', '3884617888');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AH415IO', 'CRONOS 1,3', 'ESTEBAN', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AH504KO', 'KWUD', 'HERNAN CALA (OROCH)', '3883298486');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AH541MI', 'CRONOS 1,3', 'FEDERICO (VECINO)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AH579IO', 'BASALT 1,6', 'ORLANDO (PAPA ANDR)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AH602IL', 'LOGAN 1,6', 'WALTER (BADANY)', '3883135268');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AH916BJ', 'FIAT PULSE 1,0', 'ANDRES (ABAN)', '3884405510');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('AH995FZ', 'CHEVROLET ONYX', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('COG999', 'RANGER2,5', 'ESTEBAN', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('DUV555', 'RENAUL EXPRESS', 'JORGE (VIDAL)', '334652465');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('ELK405', 'STILO 1,8', 'GABRIEL', '3885714746');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('ENZ482', 'FIAT PALIO', 'NELSON (QUIPILDOR)', '3885089496');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('EQK447', 'HILUX 3,0', 'VECINO (PEREZ)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('FCR813', 'PEUGEOT 206', 'GUSTAVP (TEJERINA)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('FWF753', 'ESOSPORT 1,6 2006', 'QUISPE (JUAN DANIEL)', '3885129926');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('FXP342', 'FIORINO 1,3', 'EDAURDO', '3886350838');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('G978AQ', 'STRADA 1,3', 'MARTIN', '3884217180');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('GEN278', 'FIAT 1 1,3', 'MARCELO (CORRALES)', '3885765037');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('GIW956', 'FIESTA MAX', 'CRISTIAN', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('GOQ958', 'FIESTA 1,6', 'VARGAS', '3884072604');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('GTK227', 'CHEVROLET CORSA 1,6 2008', 'ANGEL (ZAPANA)', '3884409493');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('GUD277', 'ECOSPORT', 'JOSE (CHAVEZ)', '3884325800');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('HEM703', 'gol 1,6', 'JUAN (GUTIERREZ)', '3884213150');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('HEX849', 'SURAN 1,6', 'LUIS (TAXIS)', '3884650848');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('HWM679', 'ECO 1,6', 'EZEQUIEL AGUILAR', '3884474254');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('HXN568', 'SANDERO', 'MATIAS', '3885400124');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('HZE403', 'CHEVROLET CORSA CLASSIC 2009', 'ANTONIO (CAUCOTA)', '3884134614');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('IDH308', 'SANDERO 1,6', 'GABRIEL (REMIS)', '3885192418');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('IEN997', 'VW FOX', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('IET805', 'FOCUS 2,0', 'RAUL', '3884617373');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('IIJ718', 'TIDDA', 'SERGIO MOLINA', '3884210691');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('IOH674', 'FOCUS 1,6', 'FLORENCIA (VECINA)', '3884487250');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('IPB983', 'VW GOL TREND 1,6', 'LUIS (SIVILA)', '3884653295');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('JCV729', 'PALIO 1,4', 'JOSE', '3884587460');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('JDL510', 'FIAT PALIO APPACE', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('JJH065', 'IDEA 1,6', 'DANIEL', '3884132923');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('JPK241', 'FOCUS', 'FABIAN', '3886852218');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('JRM491', 'C3 1,5', 'GABRIEL (CARMEN TAXI)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('JSO594', 'AGILE 1,4 2011', 'ANGEL (MURILLO)', '3885725199');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('KAU467', 'ECOSPORT 1,6 2011', 'TASTACA (ANAHI)', '3884888949');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('KED776', 'FIORINO FIRE', 'CA CARLOS', '1126169158');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('KHY774', 'FORD FIESTA 1,6', 'LEONIDAS', '3885124244');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('KKR431', 'GOL 1,6', 'LEO', '3884784602');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('KMB446', 'PAUGEOT 206 2011 1,4', 'JORGE (TEJERINA)', '3885071878');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('KQU856', 'FIAT PALIO', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('KVU660', '307 2,0', 'DANIEL', '3883350173');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('KXA462', '207 1,4', 'EMANUEL (RIVADENEIRA)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('KYE727', 'FIESTA 1,6', 'FABIAN GIMENEZ', '3883128384');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('KYU', 'CLIO 1,2 2010', 'ALEJANDRO (VIDAL)', '3885183335');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('LHH984', 'FIESTA', 'MARIANA (DIAZ)', '3884073083');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('LHO897', 'RENAULT maste', 'APPACE (CLAUDIO)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('LKO516', 'AMAROK 2,0', 'CARLOS FERNANDEZ', '3885132783');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('LLN607', 'PALIO 1,6', 'SEBASTIAN (YAPURA)', '3884179595');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('LPQ502', 'CHEVROLET S10', 'SERGIO (ACOSTA)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('LSL731', 'FIESTA', 'BAUTISTA', '3885854807');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('LVD633', 'DUSTER 2,0', 'GABRIEL (TAXI)', '3885192418');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('LVX108', 'HILUX', 'HUBER (FLETES)', '3884642742');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('LXW074', 'FIAT PALIO', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MDE619', 'RANGER 3,0', 'NORMA (ALFARO)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MEJ794', 'SPIN 1,8 2013', 'CRISTIAN (DAVILA)', '3884475572');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MFA051', 'W BORA1,9 TDI 20123', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MFT688', 'VENTO 2,0', 'TUTI', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MHW499', 'RENAULT CLIO', 'MEDINA SEBASTIAN', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MIO833', 'FIAT UNO WAY 1,4', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MLT160', 'DUSTER 2,0', 'BERNO VECINO', '3885817034');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MNY985', 'KA 1,0', 'EMANUEL (ROSALES)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MNZ307', 'A200', 'DAVID (MERCEDES)', '3886032302');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MPJ334', 'MARCH 1,6', 'DAVID ARROYO (ALQ MP)', '3885755617');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MQR315', 'PRISMA 1,4', 'NESTOR', '3456402431');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MRR251', 'PEUGEOT 308 1,6', 'ALEJO (TERESITA)', '3885177844');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MWN322', 'VW GOL', 'MAXIMILIANO', '3884704044');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MWN386', 'GOL 1,6', 'MARIO', '3884771790');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('MYS501', '208 1,5', 'ROQUE (GALLARDO)', '3885901717');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NAC999', 'CLIO 1,2', 'DIEGO', '3513851282');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NBS430', 'SANDERO 1,6 2013', 'CARRILLO (MATIAS)', '3884694852');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NCX294', 'STRADA 1,4', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NDU375', 'ONIX 2013', 'DANIEL PUCA (HNO BRIAN)', '3884674090');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NDX251', 'peugeot 408', 'MARIELA BEATRIZ CRUZ', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NFT688', 'VENTO 2,0', 'TUTI', '3884129537');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NHT030', 'SANDERO', 'CRISTIAN', '3883330421');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NIL278', 'SURAN', 'FELIX', '3884887373');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NNZ604', 'C 3 1,5', 'VENDIDO', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NOT894', 'IDEA', 'FERNANDO', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NOW724', 'PEUGEOT 308 1,6', 'GERARDO (AMADOR)', '3885198688');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NPM628', 'CORSA 1,4', 'JESUS MORENO', '3884175020');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NPM678', 'PALIO', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NQW774', 'fiesta', 'MATIAS (MENDOZA)', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NRK473', 'C4 2,0', 'ALFREDO VEGA', '3885206179');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NTU387', 'PEUGEOT 1,4 2023', 'ROMAN (IGNACIO ALBERTO)', '3884440226');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('NVY309', 'FIESTA 1,6', 'VILMA/CRISTIAN (NORTE)', '3883293959');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('OAX823', 'PALIO1,4', 'MARTIN MENDEZ', '3885927510');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('OFB870', 'PEUGEOT 208 VTI', 'NELSON', '3885768053');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('OFN073', 'FIAT PALIO 1,4 2014', 'CHOQUE (MATIAS)', '3884449148');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('ONC393', 'ONIX 1,4', 'LUIS', '3884739202');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('ONW434', 'VW GOL TREND 1,6', 'JUAN (MAMANI)', '3883339697');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('OSQ284', 'GOL 1,6', 'DIEGO', '3885707081');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('OWB083', 'SIENA 1,6', 'JOSE (CUÑADO)', '3885909595');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('PBL093', 'eco2015', 'BRIAN (SUSQUES)', '3886869273');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('PBQ195', 'FIESTA 1,6', 'DANIEL', '3885832091');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('PCH192', 'KANGOO 1,6', 'EZEEQUIEL', NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('PCH240', 'FORD FOCUS 1,6 2015', 'ABAN (TOMAS)', '3885125936');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('PIP027', 'KANGOO 1,5', 'DAVID', '3886032302');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('PJJ794', 'STRADA 1,6', 'VANESA', '3884727636');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('PMH045', 'VW FOX 1,6', 'IGNACIO', '3885086831');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('POU065', 'PEUGEOT 207', NULL, NULL);
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('SUZ3853', 'FIAT ARGO 1,3', 'TARIFA (GUSTAVO)', '3885775488');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('TA', 'VW GOL', 'VICTOR', '3884585266');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('TEQ869', 'ASTRA', 'CAROLINA', '3885091106');
INSERT INTO vehicles (license_plate, brand_model, owner_name, phone)
VALUES ('UDQ058', 'ESCORT 1,6', 'CLAUDIO (GALLARDO)', '3884212015');

-- ============================================================
-- Historial de services (235 registros)
-- ============================================================

-- Fila 2: LHO897 - 2026-03-31
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-03-31 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'SE CAMBIO ACEITE DE CAJA')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'LHO897'),
           268590,
           'Próximo service: 278590 km | SE CAMBIO ACEITE DE CAJA'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 3271/3 WOE 506 FCD 0816/2'),
            ('Aceite: 15W40 SELENIA')
        ) AS detail(description);

-- Fila 5: PBL093 - 2026-04-03
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-03 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'VER ACEITE DE CAJA - DISTRIB - SERVI')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'PBL093'),
           55079,
           'Próximo service: 65079 km | VER ACEITE DE CAJA - DISTRIB - SERVI'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9286/F1694/WO152/'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 6: NDU375 - 2026-04-03
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-03 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NDU375'),
           149623,
           'Próximo service: 159623 km | S/N'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F3286/W130/A723'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 7: MLT160 - 2026-04-06
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-06 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MLT160'),
           58995,
           'Próximo service: 68995 km | S/N'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9272/W200/F1630/A1397'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 8: AD023TQ - 2026-04-06
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-06 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD023TQ'),
           86141,
           'Próximo service: 96141 km | S/N'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4892/W110/F2035/A1446'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 9: AF902ZS - 2026-04-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF902ZS'),
           53494,
           'Próximo service: 63494 km | S/N'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT AMAROK 0922'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 10: MEJ794 - 2026-04-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'SE CAMBIO REFRI YPF/ PROXIMO HIDRULICO FRENO CAJA')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MEJ794'),
           124476,
           'Próximo service: 135000 km | SE CAMBIO REFRI YPF/ PROXIMO HIDRULICO FRENO CAJA'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F3269/W130/A723'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 11: AC086XY - 2026-04-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'PROX AA Y ACEITE DE CAJA')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC086XY'),
           106215,
           'Próximo service: 116215 km | PROX AA Y ACEITE DE CAJA'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F7019/W156/F1694'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 12: AD951AE - 2026-04-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD951AE'),
           65635,
           'Próximo service: 75635 km | S/N'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2829/W121/F1600/A323'),
            ('Aceite: 0W20 TMB')
        ) AS detail(description);

-- Fila 13: NAC999 - 2026-04-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', NULL)
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NAC999'),
           142361,
           'Próximo service: 152361 km'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4872-1/W205/F1630'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 14: AD284LW - 2026-04-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'SHELL UBER $50000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD284LW'),
           216502,
           'Próximo service: 226502 km | SHELL UBER $50000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F7007/W340'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 15: AB482YZ - 2026-04-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'FC PROX. EF $135000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB482YZ'),
           156983,
           'Próximo service: 167000 km | FC PROX. EF $135000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4892/W110/A1446'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 16: AA105RV - 2026-04-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'CUIDADO TURCA CARTER $60000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA105RV'),
           159318,
           'Próximo service: 169318 km | CUIDADO TURCA CARTER $60000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2928/W121/F1600/A323'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 17: AB898IP - 2026-04-09
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-09 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N $ 134500')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB898IP'),
           89063,
           'Próximo service: 99063 km | S/N $ 134500'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F7019/W156/F1694'),
            ('Aceite: 5W30MC ENV')
        ) AS detail(description);

-- Fila 19: AB602IB - 2026-04-10
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-10 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'TAXIS PRECIO $55000 PAGO CON NX 66000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB602IB'),
           293829,
           'Próximo service: 303829 km | TAXIS PRECIO $55000 PAGO CON NX 66000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/W120'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 20: AG568HJ - 2026-04-13
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-13 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'COMPLETO $145000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AG568HJ'),
           21560,
           'Próximo service: 31560 km | COMPLETO $145000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2829/W121/F1600/A323'),
            ('Aceite: 0W20 ENV PET')
        ) AS detail(description);

-- Fila 21: AE618AX - 2026-04-14
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-14 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'PERICO $45000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE618AX'),
           286987,
           'Próximo service: 297000 km | PERICO $45000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2829/W121'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 22: AF720XH - 2026-04-14
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-14 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N $110000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF720XH'),
           64230,
           'Próximo service: 74230 km | S/N $110000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT JEEP /TORO'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 23: NFT688 - 2026-04-14
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-14 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N $50000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NFT688'),
           337477,
           'Próximo service: 347477 km | S/N $50000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F ACEITE W640'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 24: AB385WN - 2026-04-15
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-15 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N $95000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB385WN'),
           159179,
           'Próximo service: 169179 km | S/N $95000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: WR150/W138/A723'),
            ('Aceite: 0W20 TMB')
        ) AS detail(description);

-- Fila 25: AD800OB - 2026-04-15
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-15 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N $105000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD800OB'),
           70856,
           'Próximo service: 80856 km | S/N $105000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/W200/F1630/A1397'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 26: AA856UJ - 2026-04-15
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-15 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '250000 FC PROX')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA856UJ'),
           1520690,
           'Próximo service: 162690 km | 250000 FC PROX'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F8001-1/WOE506/A1993'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 27: AC404CN - 2026-04-15
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-15 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'PIERDE ACEITE Y REFRI $150 /190 TJT')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC404CN'),
           250192,
           'Próximo service: 260192 km | PIERDE ACEITE Y REFRI $150 /190 TJT'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: W626/J0998/F0793/A2108 KIT 2,0'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 28: JPK241 - 2026-04-17
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-17 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'PROXIMO COMB. HAB. $60000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'JPK241'),
           184287,
           'Próximo service: 194287 km | PROXIMO COMB. HAB. $60000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: WR192/W160'),
            ('Aceite: 15W40 TMB')
        ) AS detail(description);

-- Fila 29: AC587BR - 2026-04-17
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-17 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N $75000 CON FOCOS $ 68000 SERV')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC587BR'),
           184275,
           'Próximo service: 194275 km | S/N $75000 CON FOCOS $ 68000 SERV'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F7007/W340/F1620/A163'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 30: MDE619 - 2026-04-17
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-17 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N $225000 USA 3 BDN')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MDE619'),
           228148,
           'Próximo service: 238148 km | S/N $225000 USA 3 BDN'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT RANGER 3,2'),
            ('Aceite: 10W40 MCR ENV')
        ) AS detail(description);

-- Fila 31: AH579IO - 2026-04-17
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-17 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'PRXO F. HAB $90000 DBT')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AH579IO'),
           41684,
           'Próximo service: 51684 km | PRXO F. HAB $90000 DBT'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4895/W710/F1630'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 32: AF757QZ - 2026-04-17
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-17 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N $75000 TAXI AMARILLO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF757QZ'),
           347214,
           'Próximo service: 357214 km | S/N $75000 TAXI AMARILLO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/W120'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 33: NVY309 - 2026-04-20
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-20 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'TAPON CARTER FALLA ULTIMO SERV RETIRARON MATERIAL $110000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NVY309'),
           NULL,
           'TAPON CARTER FALLA ULTIMO SERV RETIRARON MATERIAL $110000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9286/F1694/WO152/A347F'),
            ('Aceite: 10W40 MCR ENV')
        ) AS detail(description);

-- Fila 34: FXP342 - 2026-04-20
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-20 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'pierde caja/ tiene sandero f9299 -')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'FXP342'),
           213000,
           'Próximo service: 223000 km | pierde caja/ tiene sandero f9299 -'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2031/W120'),
            ('Aceite: 20W50 TMB')
        ) AS detail(description);

-- Fila 35: AD123BT - 2026-04-20
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-20 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'TAPA MAL CUIDADO, FCI+AKX PROX $75000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD123BT'),
           54652,
           'Próximo service: 64652 km | TAPA MAL CUIDADO, FCI+AKX PROX $75000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F6013/W710'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 36: HWM679 - 2026-04-22
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-22 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'VER NIVEL Y ESTADO $68000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'HWM679'),
           178494,
           'Próximo service: 188494 km | VER NIVEL Y ESTADO $68000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9003/W180/F1695'),
            ('Aceite: 10W40 MCR ENV')
        ) AS detail(description);

-- Fila 37: AF817OK - 2026-04-22
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-22 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '220000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF817OK'),
           78046,
           'Próximo service: 88046 km | 220000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT V6'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 38: LVD633 - 2026-04-23
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-23 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'REMIS CARMEN. $45000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'LVD633'),
           189055,
           'Próximo service: 199055 km | REMIS CARMEN. $45000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9273/W200'),
            ('Aceite: 15W40 TMB')
        ) AS detail(description);

-- Fila 40: IDH308 - 2026-04-24
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-24 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'REMIS CARMEN $45000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'IDH308'),
           199629,
           'Próximo service: 209629 km | REMIS CARMEN $45000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9273/W200'),
            ('Aceite: 15W40 TMB')
        ) AS detail(description);

-- Fila 41: AB953UT - 2026-04-25
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-25 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'VER EL TAPON CARTER $70000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB953UT'),
           255620,
           'Próximo service: 265620 km | VER EL TAPON CARTER $70000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT TRACKER 1,8'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 42: KYE727 - 2026-04-27
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-27 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'UBER/ ACEITE DE CAJA $60000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'KYE727'),
           NULL,
           'UBER/ ACEITE DE CAJA $60000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9286/W152'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 43: MQR315 - 2026-04-27
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-27 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'TOTAL ENV POSIBLE/ CODIGO DE LUCES $60000 + LAVADO PROMO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MQR315'),
           129613,
           'Próximo service: 139613 km | TOTAL ENV POSIBLE/ CODIGO DE LUCES $60000 + LAVADO PROMO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F3269/W130/A723'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 44: AB244GZ - 2026-04-27
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-27 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'CAM.LHIDR/L. FREN SE CAMBIO JFC217 $120+70')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB244GZ'),
           211731,
           'Próximo service: 221731 km | CAM.LHIDR/L. FREN SE CAMBIO JFC217 $120+70'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT HILUX 2016 + JFC217'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 45: LLN607 - 2026-04-29
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-29 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'SE PRENDE TESTGO CHEK $75000 PRXO AA')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'LLN607'),
           114223,
           'Próximo service: 124223 km | SE PRENDE TESTGO CHEK $75000 PRXO AA'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9121/W912/F1600/'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 46: PBQ195 - 2026-04-30
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-30 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N COMPRO TODO EL KIT')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'PBQ195'),
           92713,
           'Próximo service: 102713 km | S/N COMPRO TODO EL KIT'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9286/W152/F1694/347F'),
            ('Aceite: 5W30 ENV MC')
        ) AS detail(description);

-- Fila 47: AF8580TD - 2026-04-30
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-30 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF8580TD'),
           NULL,
           'S/N'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4895/W710/A1452/2'),
            ('Aceite: 5W30 TOTAL EN')
        ) AS detail(description);

-- Fila 48: GEN278 - 2026-04-30
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-04-30 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'CAJA/PASTILLAS/ L FRENO/ TANQUE PINCHADO $60000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'GEN278'),
           242688,
           'Próximo service: 252688 km | CAJA/PASTILLAS/ L FRENO/ TANQUE PINCHADO $60000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4033/W120/F1610'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 49: AH541MI - 2026-05-02
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-02 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N $75000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AH541MI'),
           30231,
           'Próximo service: 40231 km | S/N $75000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2829/W121'),
            ('Aceite: 0W20 TMB')
        ) AS detail(description);

-- Fila 50: GOQ958 - 2026-05-04
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-04 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'NO FUNCIONA AA/CC $60000 - BUSCA PRE')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'GOQ958'),
           298223,
           'Próximo service: 308223 km | NO FUNCIONA AA/CC $60000 - BUSCA PRE'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9003/W180/F1695'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 51: NNZ604 - 2026-05-04
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-04 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'LASTIMADO PORTA FILTRO ACEITE')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NNZ604'),
           92998,
           'Próximo service: 102998 km | LASTIMADO PORTA FILTRO ACEITE'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: WOE710'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 52: AE619VT - 2026-05-04
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-04 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'REMIS CARMEN. $45000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE619VT'),
           439518,
           'Próximo service: 449518 km | REMIS CARMEN. $45000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F7007/W340'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 53: OAX823 - 2026-05-04
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-04 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '$50000 X Q TRAJO ACEITE')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'OAX823'),
           177159,
           'Próximo service: 187159 km | $50000 X Q TRAJO ACEITE'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2831/W120/F1600/A3212'),
            ('Aceite: 15W40 TMB')
        ) AS detail(description);

-- Fila 54: AF452YN - 2026-05-04
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-04 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '$105000 S/N')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF452YN'),
           90508,
           'Próximo service: 100508 km | $105000 S/N'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/W120/F1630/A1944'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 55: AF824HG - 2026-05-05
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-05 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '$150000. PEND F. COMB S/N')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF824HG'),
           111329,
           'Próximo service: 121329 km | $150000. PEND F. COMB S/N'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F8001-1/WOE506/A1993'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 56: AC157TX - 2026-05-05
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-05 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'CAMB. P.FRENO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC157TX'),
           102268,
           'Próximo service: 112268 km | CAMB. P.FRENO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F7007/W340/F1630/A163'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 57: AC592LQ - 2026-05-05
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-05 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '4LTS ? $45000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC592LQ'),
           176424,
           'Próximo service: 186424 km | 4LTS ? $45000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2219/W340'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 58: AE225XF - 2026-05-06
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-06 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N $140600')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE225XF'),
           230353,
           'Próximo service: 240353 km | S/N $140600'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/W120/F1630/A1399'),
            ('Aceite: 5W40 ELF ENV')
        ) AS detail(description);

-- Fila 59: AA379IW - 2026-05-06
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-06 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '$55000 +FOCO GUIÑO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA379IW'),
           151520,
           'Próximo service: 161520 km | $55000 +FOCO GUIÑO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F3286/W130'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 60: AA848XN - 2026-05-06
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-06 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'VER ACEITE CAJA PROX. PIERDE ACEITE')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA848XN'),
           262569,
           'Próximo service: 272569 km | VER ACEITE CAJA PROX. PIERDE ACEITE'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT AMAROK 0922'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 61: IIJ718 - 2026-05-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'VENDIDO. PIERDE ACEITE POR CARTER $55000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'IIJ718'),
           196425,
           'Próximo service: 206425 km | VENDIDO. PIERDE ACEITE POR CARTER $55000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: JFA0134/WO205'),
            ('Aceite: 10W40TMB')
        ) AS detail(description);

-- Fila 62: AE172FV - 2026-05-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'CAMBIAR F AORE MOT $55000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE172FV'),
           66870,
           'Próximo service: 76870 km | CAMBIAR F AORE MOT $55000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: W120/F1630'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 63: PJJ794 - 2026-05-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '70000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'PJJ794'),
           112369,
           'Próximo service: 122369 km | 70000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9121/W912/F1600/'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 64: GIW956 - 2026-05-09
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-09 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '37000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'GIW956'),
           149873,
           'Próximo service: 159873 km | 37000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: W180'),
            ('Aceite: 15W40 TMB')
        ) AS detail(description);

-- Fila 65: AF365CP - 2026-05-09
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-09 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'VER BUJIAS Y CABLE PROX $')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF365CP'),
           80289,
           'Próximo service: 90289 km | VER BUJIAS Y CABLE PROX $'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F48723/W710/F1630/A1444-2'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 66: AE342WI - 2026-05-09
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-09 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'PROX CAMBIO BUJIAS Y CABLES $100000 | SABADO CAMBIO REFRI 50000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE342WI'),
           47223,
           'Próximo service: 57223 km | PROX CAMBIO BUJIAS Y CABLES $100000 | SABADO CAMBIO REFRI 50000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9054/W120/F1600/A'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 67: AB249VV - 2026-05-11
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-11 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'PROX. F COMB. PASTILLAS/CAJA/FRENO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB249VV'),
           107910,
           'Próximo service: 117910 km | PROX. F COMB. PASTILLAS/CAJA/FRENO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: W626/J0998/F0793/A2108 KIT 2,0'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 68: MNZ307 - 2026-05-11
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-11 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'LLEVA 6LTS 210000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MNZ307'),
           138292,
           'Próximo service: 148292 km | LLEVA 6LTS 210000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT CLASE A 200'),
            ('Aceite: 5W30 PET ENV')
        ) AS detail(description);

-- Fila 69: AF602IB - 2026-05-11
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-11 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'NX 66000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF602IB'),
           303618,
           'Próximo service: 313618 km | NX 66000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/W120'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 70: AB196JD - 2026-05-12
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-12 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'F.A +F.C QUEDA A FAVOR 500 CC DE 5W30 GULF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB196JD'),
           367379,
           'Próximo service: 377379 km | F.A +F.C QUEDA A FAVOR 500 CC DE 5W30 GULF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: JFO0211/AKX-1967'),
            ('Aceite: 5W30 GULF ENV')
        ) AS detail(description);

-- Fila 71: AB639UR - 2026-05-12
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-12 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'SE CAMBIO L FRENO 141000 TJT LUZ AIRBAG / CHEK SERV')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB639UR'),
           121752,
           'Próximo service: 131752 km | SE CAMBIO L FRENO 141000 TJT LUZ AIRBAG / CHEK SERV'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F7007/W340/F1630/A163'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 72: AD702RZ - 2026-05-12
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-12 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '150000 VER ACEITE DE CAJA Y L FFRENO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD702RZ'),
           153351,
           'Próximo service: 163351 km | 150000 VER ACEITE DE CAJA Y L FFRENO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2219/W340/A1129F'),
            ('Aceite: 5W40 SHELL EV')
        ) AS detail(description);

-- Fila 73: OWB083 - 2026-05-13
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-13 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '75000 VISA MACRO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'OWB083'),
           183646,
           'Próximo service: 193646 km | 75000 VISA MACRO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9121/W912/F1600/'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 74: AB762PE - 2026-05-13
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-13 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '50000 EF TAXI')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB762PE'),
           776672,
           'Próximo service: 786672 km | 50000 EF TAXI'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F7007/W340'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 75: IOH674 - 2026-05-13
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-13 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '100000 BUEN ESTADO S/N')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'IOH674'),
           109336,
           'Próximo service: 119336 km | 100000 BUEN ESTADO S/N'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: WR192/W152/F1694/A3594F'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 76: MYS501 - 2026-05-13
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-13 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'SE CAMBIO ACEITE DE CAJA 143264')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MYS501'),
           150970,
           'Próximo service: 160970 km | SE CAMBIO ACEITE DE CAJA 143264'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4873/W710/F1630/1444-2'),
            ('Aceite: 10W40 ELF')
        ) AS detail(description);

-- Fila 77: AH602IL - 2026-05-14
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-14 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'OKM - VER PARA EL PROX Q SE HACE')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AH602IL'),
           13000,
           'Próximo service: 23000 km | OKM - VER PARA EL PROX Q SE HACE'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/W120'),
            ('Aceite: 5W40 ELF ENV')
        ) AS detail(description);

-- Fila 78: AB550EO - 2026-05-15
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-15 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'PROX CAJA/HIDRUL/FRENOS 135000+ LAVADO 9')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB550EO'),
           174368,
           'Próximo service: 184368 km | PROX CAJA/HIDRUL/FRENOS 135000+ LAVADO 9'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4892/A1446/F2035/W110'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 79: AA030NL - 2026-05-15
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-15 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'CAJA/FRENO/HIDRAULICO 190000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA030NL'),
           144612,
           'Próximo service: 154612 km | CAJA/FRENO/HIDRAULICO 190000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT AMAROK 0922'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 80: AA926TE - 2026-05-16
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-16 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '135000 L FRENO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA926TE'),
           61312,
           'Próximo service: 71312 km | 135000 L FRENO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9295/A347F/F1694/W152'),
            ('Aceite: 5W30 MC ENV')
        ) AS detail(description);

-- Fila 81: AG152SF - 2026-05-16
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-16 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'PROX AA')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AG152SF'),
           18392,
           'Próximo service: 28392 km | PROX AA'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2829/F1600/W121'),
            ('Aceite: 0W20 GULF ENV')
        ) AS detail(description);

-- Fila 82: AF455QR - 2026-05-16
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-16 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'TAXI COMP')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF455QR'),
           105421,
           'Próximo service: 106421 km | TAXI COMP'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2219/W340'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 83: PCH192 - 2026-05-16
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-16 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '70000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'PCH192'),
           NULL,
           '70000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9273/W200/F1630/A1397'),
            ('Aceite: 10W40TMB')
        ) AS detail(description);

-- Fila 84: AA416DB - 2026-05-19
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-19 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'F COM PROX. L HIDR. FRENO. 125000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA416DB'),
           90728,
           'Próximo service: 100728 km | F COM PROX. L HIDR. FRENO. 125000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: JFA0F12/A1700/F1660/W930'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 85: AC080CJ - 2026-05-19
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-19 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'TAXIS 40000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC080CJ'),
           466699,
           'Próximo service: 476699 km | TAXIS 40000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2831/W120/F1600/A3212'),
            ('Aceite: 15W40 TMB')
        ) AS detail(description);

-- Fila 86: AH504KO - 2026-05-21
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-21 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '157000 AIRBAG REVISAR -')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AH504KO'),
           20031,
           'Próximo service: 30031 km | 157000 AIRBAG REVISAR -'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT KWID'),
            ('Aceite: 5W30 TOTAL EN')
        ) AS detail(description);

-- Fila 87: KED776 - 2026-05-22
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-22 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'CAJA CAMB COMPLETA ACEITE')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'KED776'),
           393618,
           'Próximo service: 403618 km | CAJA CAMB COMPLETA ACEITE'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4033/W120'),
            ('Aceite: 10W40 PET ENV')
        ) AS detail(description);

-- Fila 88: AE618AU - 2026-05-23
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-23 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'ACEITE DE CAJA 115000 TJT 6')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE618AU'),
           156265,
           'Próximo service: 166265 km | ACEITE DE CAJA 115000 TJT 6'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F3233/A723/W138'),
            ('Aceite: 5W30 ACEDL ENV')
        ) AS detail(description);

-- Fila 89: AG990TT - 2026-05-27
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-27 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'PROX COMB 83000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AG990TT'),
           103014,
           'Próximo service: 113014 km | PROX COMB 83000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/W120'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 90: MPJ334 - 2026-05-27
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-27 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'FRENOS/ HIDRUALICO 90000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MPJ334'),
           199465,
           'Próximo service: 209465 km | FRENOS/ HIDRUALICO 90000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: J0131/W205'),
            ('Aceite: 10W40 TOTAL EN')
        ) AS detail(description);

-- Fila 91: AC511NY - 2026-05-27
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-27 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'FRENOS/ HIDRUALICO 90000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC511NY'),
           92805,
           'Próximo service: 102805 km | FRENOS/ HIDRUALICO 90000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2219/W340/A1129F'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 92: LKO516 - 2026-05-28
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-28 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N 200000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'LKO516'),
           199037,
           'Próximo service: 209037 km | S/N 200000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT AMAROK 0919'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 93: AE970BO - 2026-05-28
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-28 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N 165000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE970BO'),
           53033,
           'Próximo service: 63033 km | S/N 165000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT HILUX 16'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 94: AG181XO - 2026-05-29
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-29 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N 95000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AG181XO'),
           71708,
           'Próximo service: 81708 km | S/N 95000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2219/A323/1600/W121'),
            ('Aceite: 0W20 TMB')
        ) AS detail(description);

-- Fila 95: AB980KF - 2026-05-29
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-29 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '95000 KM')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB980KF'),
           173586,
           'Próximo service: 183586 km | 95000 KM'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9054/W120/F1600/'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 96: AA432FJ - 2026-05-30
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-05-30 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'SE CAMBIO L HIDR. 120000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA432FJ'),
           82548,
           'Próximo service: 92548 km | SE CAMBIO L HIDR. 120000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9121/W912/F1600/A1375'),
            ('Aceite: 10W40 TOTAL EN')
        ) AS detail(description);

-- Fila 97: JCV729 - 2026-06-02
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-02 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '70000 EF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'JCV729'),
           112762,
           'Próximo service: 122762 km | 70000 EF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2831/W120/F1600/A321'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 98: MWN386 - 2026-06-03
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-03 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '69000 SIN F HABIT. PROX.')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MWN386'),
           163461,
           'Próximo service: 173461 km | 69000 SIN F HABIT. PROX.'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F3206/W370/F1630'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 99: NCX294 - 2026-06-04
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-04 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'TJA 95000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NCX294'),
           81819,
           'Próximo service: 91819 km | TJA 95000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2831/W120/F1600/A321'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 100: AE689TZ - 2026-06-04
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-04 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '124000 EF SIN FILTRO COMB | AKX2207')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE689TZ'),
           35311,
           'Próximo service: 45311 km | 124000 EF SIN FILTRO COMB | AKX2207'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9273/W200/A1397'),
            ('Aceite: 5W30 TOTAL EN')
        ) AS detail(description);

-- Fila 101: AD748MV - 2026-06-05
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-05 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'CAMBIO DE ACEITE CAJA FILTRO NAFATA ALUM')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD748MV'),
           61447,
           'Próximo service: 71447 km | CAMBIO DE ACEITE CAJA FILTRO NAFATA ALUM'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4873/W710/1101C/1444-2'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 102: NRK473 - 2026-06-05
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-05 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'LIQ FREN. LIQ. HIDR. LIQ REFRI 100000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NRK473'),
           168236,
           'Próximo service: 178236 km | LIQ FREN. LIQ. HIDR. LIQ REFRI 100000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9013/W710/F1630/ A'),
            ('Aceite: 10W40')
        ) AS detail(description);

-- Fila 103: LPQ502 - 2026-06-06
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-06 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'debe 65000 145000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'LPQ502'),
           281822,
           'Próximo service: 291822 km | debe 65000 145000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: kit s10'),
            ('Aceite: 10w40 tmb')
        ) AS detail(description);

-- Fila 104: NPM628 - 2026-06-06
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-06 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'PROX CAMBIO LIQ FRENO. LI H LIQ CAJA')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NPM628'),
           77414,
           'Próximo service: 87414 km | PROX CAMBIO LIQ FRENO. LI H LIQ CAJA'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2827/W130/F1660'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 105: HEX849 - 2026-06-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '60000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'HEX849'),
           183311,
           'Próximo service: 193311 km | 60000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F3287/W340/F1620'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 106: AA679EL - 2026-06-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'NO ES SU AUTO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA679EL'),
           164863,
           'Próximo service: 174863 km | NO ES SU AUTO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4878-1/W200'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 107: PIP027 - 2026-06-09
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-09 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'LIM MOTOR. PROX CAM REFRI Y CAJA')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'PIP027'),
           187984,
           'Próximo service: 197984 km | LIM MOTOR. PROX CAM REFRI Y CAJA'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: W200/FCD0913'),
            ('Aceite: 5W40 TOTAL E')
        ) AS detail(description);

-- Fila 108: AC587BR - 2026-06-10
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-10 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '75000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC587BR'),
           194903,
           'Próximo service: 204903 km | 75000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F7007/A136/F1620/W3400'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 109: AF602IB - 2026-06-10
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-10 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '70000 NX')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF602IB'),
           313070,
           'Próximo service: 323070 km | 70000 NX'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/W120'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 110: LVD633 - 2026-06-11
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-11 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '35000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'LVD633'),
           199570,
           'Próximo service: 209570 km | 35000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: W200'),
            ('Aceite: 15W40')
        ) AS detail(description);

-- Fila 112: MFT688 - 2026-06-11
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-11 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '63000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MFT688'),
           345112,
           'Próximo service: 355112 km | 63000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: W640'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 113: NOT894 - 2026-06-12
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-12 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '12000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NOT894'),
           189600,
           'Próximo service: 199600 km | 12000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9121'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 114: AF789RW - 2026-06-12
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-12 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '150000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF789RW'),
           72776,
           'Próximo service: 82776 km | 150000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT TORO DIESEL'),
            ('Aceite: 5W33TMB')
        ) AS detail(description);

-- Fila 115: AF757QZ - 2026-06-12
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-12 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '80000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF757QZ'),
           366261,
           'Próximo service: 376261 km | 80000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/W120'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 116: AE250VD - 2026-06-12
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-12 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '80000 EF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE250VD'),
           101699,
           'Próximo service: 111699 km | 80000 EF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/W120'),
            ('Aceite: 10W40 TOTAL EN')
        ) AS detail(description);

-- Fila 117: MNY985 - 2026-06-13
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-13 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '75000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MNY985'),
           138829,
           'Próximo service: 148829 km | 75000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9003/W180/F1660'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 118: AE618AX - 2026-06-13
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-13 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '55000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE618AX'),
           NULL,
           '55000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2829/W121'),
            ('Aceite: 10W40')
        ) AS detail(description);

-- Fila 119: JRM491 - 2026-06-13
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-13 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '35000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'JRM491'),
           NULL,
           '35000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: W710'),
            ('Aceite: 15W40')
        ) AS detail(description);

-- Fila 120: AH415IO - 2026-06-13
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-13 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '100000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AH415IO'),
           52987,
           'Próximo service: 62987 km | 100000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2829/A321/F1600/W121'),
            ('Aceite: 0W20 TMB')
        ) AS detail(description);

-- Fila 121: COG999 - 2026-06-16
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-16 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '75000 SIN AIRE MOTOR')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'COG999'),
           100,
           'Próximo service: 100 km | 75000 SIN AIRE MOTOR'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9002/W180/F1660'),
            ('Aceite: 15W40 TMB')
        ) AS detail(description);

-- Fila 122: AB093FW - 2026-06-16
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-16 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '55000 PROX SERV')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB093FW'),
           184442,
           'Próximo service: 194442 km | 55000 PROX SERV'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9054/W120/F1600'),
            ('Aceite: 15W40')
        ) AS detail(description);

-- Fila 123: AA390IN - 2026-06-17
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-17 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'CAMB PAST FRENO 85000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA390IN'),
           103172,
           'Próximo service: 113172 km | CAMB PAST FRENO 85000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9273/W200/F1630'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 124: AC844QR - 2026-06-19
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-19 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'PAL PROX COMPLETO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC844QR'),
           114547,
           'Próximo service: 124547 km | PAL PROX COMPLETO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2802/W912'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 125: OSQ284 - 2026-06-19
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-19 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '115000 PROX CAJA Y FRENO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'OSQ284'),
           120310,
           'Próximo service: 130310 km | 115000 PROX CAJA Y FRENO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F7007/A163/F1630/W340'),
            ('Aceite: 10W40 SHELL ENV')
        ) AS detail(description);

-- Fila 126: AG256FN - 2026-06-19
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-19 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '160000 MACRO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AG256FN'),
           53050,
           'Próximo service: 63050 km | 160000 MACRO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2829/F1600/W121'),
            ('Aceite: 0W20 GULF ENV')
        ) AS detail(description);

-- Fila 127: AA574PM - 2026-06-20
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-20 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '57000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA574PM'),
           NULL,
           '57000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2831/W120'),
            ('Aceite: 10W40 SHELL TMB')
        ) AS detail(description);

-- Fila 128: ONC393 - 2026-06-22
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-22 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'SE CAMBIO TORNILLO CARTER | 95000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'ONC393'),
           127115,
           'Próximo service: 137115 km | SE CAMBIO TORNILLO CARTER | 95000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F3286/A723/W130'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 129: KVU660 - 2026-06-23
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-23 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', NULL)
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'KVU660'),
           165989,
           'Próximo service: 175989 km'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4054-2/A1446/F1630/W710'),
            ('Aceite: 10W40 TOTAL EN')
        ) AS detail(description);

-- Fila 130: AC256BW - 2026-06-24
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-24 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'COMPLETO TJTA 130')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC256BW'),
           168016,
           'Próximo service: 178016 km | COMPLETO TJTA 130'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2829/A323/F1600/W121'),
            ('Aceite: 0W20 TMB')
        ) AS detail(description);

-- Fila 131: AF660KK - 2026-06-25
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-25 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'CAMB P FRENO.')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF660KK'),
           79266,
           'Próximo service: 89266 km | CAMB P FRENO.'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4041/A2161/JFO0210'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 132: KKR431 - 2026-06-25
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-25 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '45000 OJO FILTRO AIREGARGANTA ROTA')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'KKR431'),
           229613,
           'Próximo service: 239613 km | 45000 OJO FILTRO AIREGARGANTA ROTA'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F7007/W340'),
            ('Aceite: 15W40')
        ) AS detail(description);

-- Fila 133: LVX108 - 2026-06-26
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-26 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'PROX AIRE MOT. 180')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'LVX108'),
           232287,
           'Próximo service: 242287 km | PROX AIRE MOT. 180'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: JFO0211/JFC207-2'),
            ('Aceite: 10W40 SHEL ENV')
        ) AS detail(description);

-- Fila 134: AD386LS - 2026-06-26
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-26 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'ROTACION CUB. 135')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD386LS'),
           142256,
           'Próximo service: 152256 km | ROTACION CUB. 135'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/A1397/F1630/W200'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 135: IET805 - 2026-06-26
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-26 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'COMPLETO. 125')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'IET805'),
           228118,
           'Próximo service: 238118 km | COMPLETO. 125'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: W192/A163/F1660/W152'),
            ('Aceite: 10W40 SHEL TMB')
        ) AS detail(description);

-- Fila 136: AE044DA - 2026-06-26
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-26 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '155000 COMPLETO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE044DA'),
           74500,
           'Próximo service: 84500 km | 155000 COMPLETO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9054/A323/F1600/W120'),
            ('Aceite: 5W30 TOTAL EN')
        ) AS detail(description);

-- Fila 137: KXA462 - 2026-06-29
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-29 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '100 BORNE SULFATADO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'KXA462'),
           159950,
           'Próximo service: 169950 km | 100 BORNE SULFATADO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F6000/W710/F1630/A35157'),
            ('Aceite: 10W40 YPF ENV')
        ) AS detail(description);

-- Fila 138: HEM703 - 2026-06-30
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-30 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'S/N 60000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'HEM703'),
           0,
           'Próximo service: 0 km | S/N 60000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F3206/W370/F1620'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 139: UDQ058 - 2026-06-30
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-06-30 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'WO250? SE CAMBIO ACEITGE DE CAJA')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'UDQ058'),
           97167,
           'Próximo service: 107167 km | WO250? SE CAMBIO ACEITGE DE CAJA'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FRAN PH2863'),
            ('Aceite: 10W40 TOTAL EN')
        ) AS detail(description);

-- Fila 140: EQK447 - 2026-07-01
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-01 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '35000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'EQK447'),
           NULL,
           '35000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: JFO0113'),
            ('Aceite: 15W40')
        ) AS detail(description);

-- Fila 141: JJH065 - 2026-07-02
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-02 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'MANGUERA DEP. HIDRA. 75')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'JJH065'),
           209162,
           'Próximo service: 219162 km | MANGUERA DEP. HIDRA. 75'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9121/A35321/F1600/W912'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 142: NPM678 - 2026-01-01
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-01-01 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', NULL)
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NPM678'),
           167724,
           'Próximo service: 177724 km'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9121/A35321/F1600/W912')
        ) AS detail(description);

-- Fila 143: ELK405 - 2026-07-02
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-02 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'TAPON PARA CAMBIO 60')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'ELK405'),
           138031,
           'Próximo service: 148031 km | TAPON PARA CAMBIO 60'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4208/A35711/F1600/W121'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 144: AF602IB - 2026-07-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '65000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF602IB'),
           322484,
           'Próximo service: 332484 km | 65000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/W120/F1630'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 145: AB712MK - 2026-07-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '55000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB712MK'),
           96493,
           'Próximo service: 106493 km | 55000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2831/W120/F1600'),
            ('Aceite: 10W40 TMB')
        ) AS detail(description);

-- Fila 146: AA134EJ - 2026-07-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'TRAE ACEITE 45000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA134EJ'),
           121209,
           'Próximo service: 131209 km | TRAE ACEITE 45000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9286/A347F/F1694/W152'),
            ('Aceite: 10W40 ENV')
        ) AS detail(description);

-- Fila 147: G978AQ - 2026-07-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'COMPLETO 125000')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'G978AQ'),
           48012,
           'Próximo service: 58012 km | COMPLETO 125000'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2829/A323/F1600/W121'),
            ('Aceite: 0W20 ENVASADO')
        ) AS detail(description);

-- Fila 148: AG - 2026-07-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '225000 COMPEL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AG'),
           4476,
           'Próximo service: 14476 km | 225000 COMPEL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4059/JFO-0218/ VER EL RESTO'),
            ('Aceite: 0W20 GULF ENV')
        ) AS detail(description);

-- Fila 149: AA107HJ - 2026-07-13
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-13 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'COMPLETO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA107HJ'),
           NULL,
           'COMPLETO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9286/A35347F/FCI1694/WO152'),
            ('Aceite: 10W40')
        ) AS detail(description);

-- Fila 150: AG239MB - 2026-07-13
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-13 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'AIRE/ACEITE/HABIT 105000 MIL TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AG239MB'),
           60000,
           'Próximo service: 70000 km | AIRE/ACEITE/HABIT 105000 MIL TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F9299/WO215/AKX1944/'),
            ('Aceite: 5W30 TAMBOR')
        ) AS detail(description);

-- Fila 151: AF534JR - 2026-07-17
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-17 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'COMPLETO 70 MIL EFECT')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF534JR'),
           311546,
           'Próximo service: 321546 km | COMPLETO 70 MIL EFECT'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F2219/WO346/FCI1630/AKX1129F'),
            ('Aceite: 10W40')
        ) AS detail(description);

-- Fila 152: AC032CE - 2026-07-22
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-22 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'COMPLETO 190 MIL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC032CE'),
           120282,
           'Próximo service: 130282 km | COMPLETO 190 MIL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT S10'),
            ('Aceite: 5W30')
        ) AS detail(description);

-- Fila 153: AB482YZ - 2026-07-24
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-24 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'COMPLETO | 150 MIL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB482YZ'),
           171340,
           'Próximo service: 181340 km | COMPLETO | 150 MIL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F4892/W110/A1446/FCD2035'),
            ('Aceite: 5W30 TMB')
        ) AS detail(description);

-- Fila 154: HZE403 - 2026-07-24
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-24 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '63 MIL EFECTIVO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'HZE403'),
           137428,
           'Próximo service: 147428 km | 63 MIL EFECTIVO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 2827/ WO 130/FCI 1660'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 155: AE695BB - 2026-07-24
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-24 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '115 MIL EFECTIVO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE695BB'),
           67555,
           'Próximo service: 77555 km | 115 MIL EFECTIVO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT JEEP /TORO'),
            ('Aceite: 5W30 TAMBOR')
        ) AS detail(description);

-- Fila 156: KYU - 2026-07-25
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-25 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '65 MIL EFECTIVO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'KYU'),
           NULL,
           '65 MIL EFECTIVO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP4872-1/WO 205/FCI 1630/ AKX 35321'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 157: AD574FR - 2026-07-25
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-25 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '83 MIL TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD574FR'),
           NULL,
           '83 MIL TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT CRONOS 1,3'),
            ('Aceite: 0W20 tamb')
        ) AS detail(description);

-- Fila 158: AF757QZ - 2026-07-29
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-29 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '87000 MIL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF757QZ'),
           380794,
           'Próximo service: 390794 km | 87000 MIL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: fap 9299/wo120'),
            ('Aceite: 5w30')
        ) AS detail(description);

-- Fila 159: AF558HD - 2026-07-30
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-30 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '105 MIL TARJ')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF558HD'),
           148607,
           'Próximo service: 158607 km | 105 MIL TARJ'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 2829/ WO 120/ FCI 1600'),
            ('Aceite: 0W20 TAMBOR')
        ) AS detail(description);

-- Fila 160: IPB983 - 2026-07-30
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-30 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '76 MIL EFECT')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'IPB983'),
           200000,
           'Próximo service: 210000 km | 76 MIL EFECT'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F7007/ WO340/ FCI 1630/ A35163'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 161: AD616 - 2026-07-31
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-07-31 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '150 MIL TARJ')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD616'),
           95496,
           'Próximo service: 105496 km | 150 MIL TARJ'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT TORO RENAGEDE'),
            ('Aceite: 5W30 TAMBOR')
        ) AS detail(description);

-- Fila 162: NTU387 - 2026-08-03
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-03 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '69 MIL EFEC')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NTU387'),
           262209,
           'Próximo service: 272209 km | 69 MIL EFEC'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F6000/W710/F1630'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 163: AB490NK - 2026-08-03
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-03 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '180 MIL EFECT')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB490NK'),
           NULL,
           '180 MIL EFECT'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT RANGER 2,2'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 164: AG239IB - 2026-08-04
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-04 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '83000 TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AG239IB'),
           61947,
           'Próximo service: 71947 km | 83000 TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 2829/ WO 121/AKX 35323'),
            ('Aceite: 0W20 TAMBOR')
        ) AS detail(description);

-- Fila 165: OFN073 - 2026-08-05
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-05 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '82 MIL EFECT')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'OFN073'),
           NULL,
           '82 MIL EFECT'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 2831/ WO120/ A 35323/ FCI 1600'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 166: NBS430 - 2026-08-06
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-06 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '111 MIL TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NBS430'),
           179000,
           'Próximo service: 189000 km | 111 MIL TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 9273/WO 200/FCI 1630/AKX 1397'),
            ('Aceite: 10W40 ELF ENVASADO')
        ) AS detail(description);

-- Fila 167: SUZ3853 - 2026-08-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '100 MIL TRANS')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'SUZ3853'),
           351690,
           'Próximo service: 361690 km | 100 MIL TRANS'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F 2829/WO 121/FCI 1600/A 35323'),
            ('Aceite: 0W20 TAMBOR')
        ) AS detail(description);

-- Fila 168: MRR251 - 2026-08-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '75 mil TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MRR251'),
           135306,
           'Próximo service: 145306 km | 75 mil TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 4873/WOE 710/FCI 1630/ A1446'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 169: PCH240 - 2026-08-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '180 MIL EFECT')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'PCH240'),
           109989,
           'Próximo service: 119989 km | 180 MIL EFECT'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: WR192/WO 156/FCI 1694/A 3594F+ A. CAJA L'),
            ('Aceite: 5W30 TAMBOR')
        ) AS detail(description);

-- Fila 170: AD056BM - 2026-08-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '145 MIL TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD056BM'),
           151222,
           'Próximo service: 161222 km | 145 MIL TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: WR192/WO 156/FCI 1694/A 3594F'),
            ('Aceite: 5W30 MOTORCRAFT ENV')
        ) AS detail(description);

-- Fila 171: AF455QR - 2026-08-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '105 MIL EFEC')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF455QR'),
           117545,
           'Próximo service: 127545 km | 105 MIL EFEC'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F 2219/ WO340/ A1129'),
            ('Aceite: 5W30 TAMBOR')
        ) AS detail(description);

-- Fila 172: KAU467 - 2026-08-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '85 MIL TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'KAU467'),
           159679,
           'Próximo service: 169679 km | 85 MIL TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F 9003/ WO 180/FCI 1695/ A35346F'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 173: FWF753 - 2026-08-10
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-10 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '96 MIL EFECT')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'FWF753'),
           305371,
           'Próximo service: 315371 km | 96 MIL EFECT'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 900/WO 180/FCI 1695+1/2 L CAJA'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 174: AC043VB - 2026-08-10
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-10 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '175 MIL TARJ')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC043VB'),
           158988,
           'Próximo service: 168988 km | 175 MIL TARJ'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F 3288/WO 340/FCI 1630/A 35163'),
            ('Aceite: 5W30 SYNTIUM PETRONAS')
        ) AS detail(description);

-- Fila 175: AF602IB - 2026-08-10
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-10 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '60 MIL TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF602IB'),
           331319,
           'Próximo service: 341319 km | 60 MIL TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: WO 120/FAP 9299'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 176: AD686IL - 2026-08-12
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-12 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '150 MIL EFECT')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD686IL'),
           139208,
           'Próximo service: 149208 km | 150 MIL EFECT'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F 3286/WO 130/A 35723'),
            ('Aceite: 5W30 TOTAL ENVASADO')
        ) AS detail(description);

-- Fila 177: AE487DR - 2026-08-12
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-12 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '75 MIL EFECT')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE487DR'),
           106998,
           'Próximo service: 116998 km | 75 MIL EFECT'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F 7007/WO 340/FCI 1630/A 35163'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 178: AD708AY - 2026-08-12
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-12 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '375 MIL EFECT')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD708AY'),
           146407,
           'Próximo service: 156407 km | 375 MIL EFECT'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT AMAROK 2016'),
            ('Aceite: 55W40 TOTAL ENVASADO')
        ) AS detail(description);

-- Fila 179: AD464RA - 2026-08-13
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-13 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '141 MIL TARJ')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD464RA'),
           87877,
           'Próximo service: 97877 km | 141 MIL TARJ'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F 925/WO 152/ FCI 1694/A 3546F'),
            ('Aceite: 5W30 TAMBOR')
        ) AS detail(description);

-- Fila 180: MFA051 - 2026-08-18
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-18 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '110 MIL TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MFA051'),
           162443,
           'Próximo service: 172443 km | 110 MIL TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAD 4045/1 /WOE610/ FCD2068'),
            ('Aceite: 5W30 TAMBOR')
        ) AS detail(description);

-- Fila 181: AC256BF - 2026-08-18
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-18 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '85 MIL TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC256BF'),
           146155,
           'Próximo service: 156155 km | 85 MIL TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F 7019/ WO 152/ FCI 1694/ A 35347F'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 182: KHY774 - 2026-08-19
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-19 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '85 MIL EFECT')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'KHY774'),
           141344,
           'Próximo service: 151344 km | 85 MIL EFECT'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F 9003/ WO 152/ FCI 1694/ A 35347F'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 183: AB375WW - 2026-08-20
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-20 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '144,500 TRAN')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB375WW'),
           NULL,
           '144,500 TRAN'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F 2219/ WO 340/ AKX 35163'),
            ('Aceite: 5W40 TOTTAL ENV')
        ) AS detail(description);

-- Fila 184: KED776 - 2026-08-21
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-21 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '81 MIL EFEC')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'KED776'),
           401250,
           'Próximo service: 411250 km | 81 MIL EFEC'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F 4033/ WO 120/ FCI 1610/'),
            ('Aceite: 10W40 PETRONA')
        ) AS detail(description);

-- Fila 185: AC404CN - 2026-08-21
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-21 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '215 TRANS')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC404CN'),
           NULL,
           '215 TRANS'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT DEFILTROS / REFRIGERANTE 5L'),
            ('Aceite: 5 W 30 TOTAL')
        ) AS detail(description);

-- Fila 186: DUV555 - 2026-08-25
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-25 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '49 MIL EFEC')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'DUV555'),
           NULL,
           '49 MIL EFEC'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: W200/ FCI 1610'),
            ('Aceite: 10W40')
        ) AS detail(description);

-- Fila 187: AC122UP - 2026-08-26
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-26 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '105 MIL EFEC')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC122UP'),
           93726,
           'Próximo service: 103726 km | 105 MIL EFEC'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 4873/WOE 710/FCI 1630/ A1444/2'),
            ('Aceite: 5W30')
        ) AS detail(description);

-- Fila 188: AH916BJ - 2026-08-27
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-27 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '130 MIL EFEC')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AH916BJ'),
           NULL,
           '130 MIL EFEC'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP2835/WO 121/FCI 1661/AKX 35323'),
            ('Aceite: 0W20 GULF ENV')
        ) AS detail(description);

-- Fila 189: AF502TA - 2026-08-27
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-27 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '64,500 MIL EFEC')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF502TA'),
           130000,
           'Próximo service: 140000 km | 64,500 MIL EFEC'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 9299/ WO 121/ FCI 1630'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 190: ONW434 - 2026-08-27
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-08-27 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '62,500 MIL EFEC')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'ONW434'),
           NULL,
           '62,500 MIL EFEC'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 7007/ WO 340/ FCI 1630'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 191: AB762PE - 2026-09-02
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-02 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '65 MIL EFECTIVO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB762PE'),
           NULL,
           '65 MIL EFECTIVO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: fap 7007/ wo 340/ fci 1630'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 192: NOW724 - 2026-09-03
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-03 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '80 MIL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NOW724'),
           121875,
           'Próximo service: 131875 km | 80 MIL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 4873/ WOE 710/ FCI 1630/ AKX 1446'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 193: NHT030 - 2026-09-03
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-03 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '75,900 MIL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NHT030'),
           NULL,
           '75,900 MIL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP9273/ F1630/ A 1397/ WO200'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 194: AA062IW - 2026-09-05
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-05 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '80 MIL TRANS')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA062IW'),
           138132,
           'Próximo service: 148132 km | 80 MIL TRANS'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FCI1620/FAP2219/WO340/AKX35163'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 195: TEQ869 - 2026-09-05
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-05 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '95 MIL transfer')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'TEQ869'),
           NULL,
           '95 MIL transfer'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: WO130/FCI1660/ak3594/f'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 196: AC592LQ - 2026-09-05
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-05 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '52 MIL EFEC')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC592LQ'),
           NULL,
           '52 MIL EFEC'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 2219/ WO340'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 197: AB249XN - 2026-09-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '95,900 TAR')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB249XN'),
           NULL,
           '95,900 TAR'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP4041/JFO0209/AKX2161'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 198: LHH984 - 2026-09-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '84,000 MIL TRAN')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'LHH984'),
           93000,
           'Próximo service: 103000 km | 84,000 MIL TRAN'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP9003/WO180/FCI1695/AKX35347/F'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 199: HXN568 - 2026-09-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '120 mil tran')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'HXN568'),
           NULL,
           '120 mil tran'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP9274/WO200/FCI1630/AKX1397'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 200: GUD277 - 2026-09-08
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-08 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '118 MIL EFEC')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'GUD277'),
           306717,
           'Próximo service: 316717 km | 118 MIL EFEC'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP4055/WOE110/FCD0915'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 201: AA402WE - 2026-09-09
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-09 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '71,200 MIL EFEC')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA402WE'),
           162712,
           'Próximo service: 172712 km | 71,200 MIL EFEC'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FA4872/1-WO200-AKX35112-FC1630'),
            ('Aceite: 10 W 40 TAMB')
        ) AS detail(description);

-- Fila 202: AC158JE - 2026-09-10
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-10 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '140 KIL TRANS')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC158JE'),
           90810,
           'Próximo service: 100810 km | 140 KIL TRANS'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: wr150/wo138/akx35723'),
            ('Aceite: 0W20 ENVASADO')
        ) AS detail(description);

-- Fila 203: AE582LI - 2026-09-14
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-14 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '55 MIL EFC')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE582LI'),
           475085,
           'Próximo service: 485085 km | 55 MIL EFC'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP7007/ WO 340'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 204: AC587BR - 2026-09-14
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-14 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '87 mil efect')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC587BR'),
           NULL,
           '87 mil efect'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP7007/WO340/FCI1620/AKX35163/H7 lampara'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 205: PMH045 - 2026-09-14
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-14 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '100 MIL EFEC')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'PMH045'),
           102800,
           'Próximo service: 112800 km | 100 MIL EFEC'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP2219/WO346/FCI1630/AKX35163'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 206: AB898KI - 2026-09-15
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-15 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '113 MIL TRAN')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB898KI'),
           NULL,
           '113 MIL TRAN'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP60123/WOE710/FCI1630'),
            ('Aceite: 5W40 GULF')
        ) AS detail(description);

-- Fila 207: NQW774 - 2026-09-15
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-15 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '105 mil trans')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NQW774'),
           128491,
           'Próximo service: 138491 km | 105 mil trans'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP9286/WO152/FCI1694/AKX35347/F'),
            ('Aceite: 10W40 motorcraf')
        ) AS detail(description);

-- Fila 208: LSL731 - 2026-09-16
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-16 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '67 MIL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'LSL731'),
           208767,
           'Próximo service: 218767 km | 67 MIL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP9003/FCI1685/WO180/'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 209: NIL278 - 2026-09-18
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-18 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '82,800 MIL TARJ')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NIL278'),
           272723,
           'Próximo service: 282723 km | 82,800 MIL TARJ'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP7007/WO340/FCI1620/'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 210: KMB446 - 2026-09-23
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-23 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '85 MIL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'KMB446'),
           NULL,
           '85 MIL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: WOE 710/FCI 1630/A 35157/FAP 3272'),
            ('Aceite: 10W40 ENV TOTAL')
        ) AS detail(description);

-- Fila 211: AF291YE - 2026-09-24
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-24 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', NULL)
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF291YE'),
           150266,
           'Próximo service: 160266 km'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 9299/WO 120/FCI 1630/ AKX 1944'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 212: POU065 - 2026-09-30
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-09-30 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '80 MIL TRANS')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'POU065'),
           NULL,
           '80 MIL TRANS'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP6000/WOE710/AKX35157/FCI1630'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 213: MWN322 - 2026-10-02
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-10-02 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '64,250 MIL QR')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MWN322'),
           181500,
           'Próximo service: 191500 km | 64,250 MIL QR'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP3602/WO370/FCI1630'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 214: AE056SZ - 2026-10-03
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-10-03 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', NULL)
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE056SZ'),
           125190,
           'Próximo service: 135190 km'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP4873/WOE710/FCI1101C/AKX1444/2'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 215: TA - 2026-10-06
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-10-06 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', NULL)
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'TA'),
           NULL,
           NULL
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 7007/ WO 340/'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 216: JSO594 - 2026-10-10
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-10-10 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', NULL)
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'JSO594'),
           NULL,
           NULL
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: WO 130/ FCI 1660'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 217: AB053OQ - 2026-10-19
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-10-19 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '63 MIL TRANSF | SOL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB053OQ'),
           250713,
           'Próximo service: 260713 km | 63 MIL TRANSF | SOL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: WO 340/F 7007/ FCI 1620'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 218: AE552WQ - 2026-10-20
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-10-20 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '230 MIL TRANSF | SOL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE552WQ'),
           20729,
           'Próximo service: 30729 km | 230 MIL TRANSF | SOL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT HILUX 2016'),
            ('Aceite: 5W30 GULF')
        ) AS detail(description);

-- Fila 219: ENZ482 - 2026-10-20
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-10-20 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', 'SOL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'ENZ482'),
           275483,
           'Próximo service: 285483 km | SOL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: F 2831/WO 120/FCI 1600/A 32321'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 221: LPQ502 - 2026-10-26
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-10-26 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '160 MIL TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'LPQ502'),
           290883,
           'Próximo service: 300883 km | 160 MIL TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT CHEVROLET S10 / REFRIGERANTE 5L'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 222: FCR813 - 2026-10-26
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-10-26 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '65 MIL TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'FCR813'),
           211657,
           'Próximo service: 221657 km | 65 MIL TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: WO160/FAP2827'),
            ('Aceite: 15W40 TAMBOR')
        ) AS detail(description);

-- Fila 224: GTK227 - 2026-10-29
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-10-29 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '65 MIL TARJETA 3CUOTAS')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'GTK227'),
           150113,
           'Próximo service: 160113 km | 65 MIL TARJETA 3CUOTAS'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP2827 / WOI130 / FCI1660'),
            ('Aceite: 15W40 TAMBOR')
        ) AS detail(description);

-- Fila 225: AB762RW - 2026-10-30
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-10-30 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '200 MIL TARJETA 3C')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB762RW'),
           144000,
           'Próximo service: 154000 km | 200 MIL TARJETA 3C'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP2219/WO340/FCI1630/AKX35163'),
            ('Aceite: 5W40 TOTAL')
        ) AS detail(description);

-- Fila 226: AF602IB - 2026-11-02
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-02 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '600 MIL TRANSFERENCIA')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AF602IB'),
           NULL,
           '600 MIL TRANSFERENCIA'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP9299/WO120'),
            ('Aceite: 10W40')
        ) AS detail(description);

-- Fila 227: IEN997 - 2026-11-03
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-03 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '90 MIL TRANS')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'IEN997'),
           211579,
           'Próximo service: 221579 km | 90 MIL TRANS'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP7007/FCI1620/WO340/AKX35163'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 228: AC587BR - 2026-11-03
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-03 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '88,5 MIL TRANS')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AC587BR'),
           226765,
           'Próximo service: 236765 km | 88,5 MIL TRANS'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP7007/FCI1620/WO340/AKX35163/AH-2502 X2/ AS-2346 MUELITA X2'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 229: AH995FZ - 2026-11-04
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-04 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', NULL)
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AH995FZ'),
           30400,
           'Próximo service: 40400 km'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: WO138'),
            ('Aceite: 0W20 GULF ENV')
        ) AS detail(description);

-- Fila 230: AE269YN - 2026-11-04
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-04 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '135 MIL TRAN')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AE269YN'),
           60000,
           'Próximo service: 70000 km | 135 MIL TRAN'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP7019/WO156/FCI1694/AKX35347F'),
            ('Aceite: 5W30 MOTORCRAFT ENV')
        ) AS detail(description);

-- Fila 231: MHW499 - 2026-11-05
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-05 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '100 MIL TRANS')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MHW499'),
           50559,
           'Próximo service: 60559 km | 100 MIL TRANS'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP4872/1 / WO205 / FCI1630 / AKX35112'),
            ('Aceite: 10W40 TOTAL EN')
        ) AS detail(description);

-- Fila 232: AA133CH - 2026-11-06
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-06 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '415 MIL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA133CH'),
           260000,
           'Próximo service: 270000 km | 415 MIL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP4046/1 / WOE680 / AKX1140/C'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 233: JDL510 - 2026-11-06
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-06 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '220 MIL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'JDL510'),
           208421,
           'Próximo service: 218421 km | 220 MIL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP2831/WO120'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 234: LHO897 - 2026-11-07
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-07 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '220 MIL')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'LHO897'),
           281929,
           'Próximo service: 291929 km | 220 MIL'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP 3271/3 WOE 680 FCD 0816/2'),
            ('Aceite: 15W40 TAMBOR')
        ) AS detail(description);

-- Fila 235: AA873JH - 2026-11-10
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-10 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '160 MIL TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AA873JH'),
           110512,
           'Próximo service: 120512 km | 160 MIL TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: KIT toro'),
            ('Aceite: 5w30 TAMBOR')
        ) AS detail(description);

-- Fila 236: AB762PE - 2026-11-10
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-10 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '60 MIL EFECTIVO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB762PE'),
           849000,
           'Próximo service: 859000 km | 60 MIL EFECTIVO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP7007 / wo340'),
            ('Aceite: 10w04 TAMBOR')
        ) AS detail(description);

-- Fila 237: OFB870 - 2026-11-11
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-11 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '130 MIL TRANSF Y TARJETA')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'OFB870'),
           76441,
           'Próximo service: 86441 km | 130 MIL TRANSF Y TARJETA'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP4873/WOE710/FCI1630/AKX1444/2'),
            ('Aceite: 10W40 TOTAL')
        ) AS detail(description);

-- Fila 239: LXW074 - 2026-11-13
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-13 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '59 MIL TARJETA')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'LXW074'),
           139000,
           'Próximo service: 140000 km | 59 MIL TARJETA'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP9091 / WOE912'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 240: KQU856 - 2026-11-14
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-14 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '114 MIL DEBITO')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'KQU856'),
           190000,
           'Próximo service: 200000 km | 114 MIL DEBITO'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP9121 / WOE912 / AKX35321 / FCI1600'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 241: MIO833 - 2026-11-14
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-14 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '91 MIL TARJETA 3CUOTAS')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'MIO833'),
           187458,
           'Próximo service: 197458 km | 91 MIL TARJETA 3CUOTAS'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP9054/WO120/AKX35323/FCI1600'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- Fila 242: AB762QU - 2026-11-16
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-16 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '109 MIL TARJETA 3CUOTAS')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AB762QU'),
           90300,
           'Próximo service: 100300 km | 109 MIL TARJETA 3CUOTAS'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP4873/WOE710/FCI1630/AKX1444/2'),
            ('Aceite: 10W40 TOTAL')
        ) AS detail(description);

-- Fila 243: AD111IY - 2026-11-16
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-16 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '130 MIL TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'AD111IY'),
           100806,
           'Próximo service: 110806 km | 130 MIL TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP2219/WO340/FCI1630/AKX1129F'),
            ('Aceite: 5W40 GULF')
        ) AS detail(description);

-- Fila 244: NDX251 - 2026-11-17
WITH inserted_sale AS (
    INSERT INTO sales (operation_date, shift, operation_type, calculated_subtotal, total_charged, status, notes)
    VALUES ('2026-11-17 00:00:00', 'MORNING', 'SERVICE', 0.00, 0.00, 'COMPLETED', '73 MIL TRANSF')
    RETURNING id
),
inserted_service AS (
    INSERT INTO vehicle_services (sale_id, vehicle_id, mileage, technical_notes)
    SELECT id,
           (SELECT id FROM vehicles WHERE license_plate = 'NDX251'),
           167815,
           'Próximo service: 177815 km | 73 MIL TRANSF'
    FROM inserted_sale
)
INSERT INTO sale_details (sale_id, product_id, description_snapshot, quantity, unit_price_snapshot)
SELECT id, NULL, detail.description, 1.00, 0.00
FROM inserted_sale
CROSS JOIN (VALUES
            ('Filtros: FAP9013/WOE710/FCI1630/AKX1446'),
            ('Aceite: 10W40 TAMBOR')
        ) AS detail(description);

-- ============================================================
-- Sincronización defensiva de secuencias
-- ============================================================

SELECT setval(pg_get_serial_sequence('vehicles', 'id'), COALESCE(MAX(id), 0) + 1, false) FROM vehicles;
SELECT setval(pg_get_serial_sequence('sales', 'id'), COALESCE(MAX(id), 0) + 1, false) FROM sales;
SELECT setval(pg_get_serial_sequence('sale_details', 'id'), COALESCE(MAX(id), 0) + 1, false) FROM sale_details;
