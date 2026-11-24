package com.lubricentromp.api.mapper;

import com.lubricentromp.api.dto.CategoryRequest;
import com.lubricentromp.api.dto.CategoryResponse;
import com.lubricentromp.api.entity.Category;
import org.springframework.stereotype.Component;

@Component
public class CategoryMapper {

    public Category toEntity(CategoryRequest request) {
        Category category = new Category();
        category.setName(normalizeName(request.name()));
        category.setActive(true);
        return category;
    }

    public void updateEntity(Category category, CategoryRequest request) {
        category.setName(normalizeName(request.name()));
    }

    public CategoryResponse toResponse(Category category) {
        return new CategoryResponse(
                category.getId(),
                category.getName(),
                category.isActive()
        );
    }

    private String normalizeName(String name) {
        return name == null ? null : name.trim();
    }
}
