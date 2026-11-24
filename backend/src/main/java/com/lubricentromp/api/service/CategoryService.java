package com.lubricentromp.api.service;

import com.lubricentromp.api.dto.CategoryRequest;
import com.lubricentromp.api.dto.CategoryResponse;
import com.lubricentromp.api.entity.Category;
import com.lubricentromp.api.exception.BusinessRuleException;
import com.lubricentromp.api.exception.ResourceNotFoundException;
import com.lubricentromp.api.mapper.CategoryMapper;
import com.lubricentromp.api.repository.CategoryRepository;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(readOnly = true)
public class CategoryService {

    private final CategoryRepository categoryRepository;
    private final CategoryMapper categoryMapper;

    public CategoryService(CategoryRepository categoryRepository, CategoryMapper categoryMapper) {
        this.categoryRepository = categoryRepository;
        this.categoryMapper = categoryMapper;
    }

    public List<CategoryResponse> listActive() {
        return categoryRepository.findByActiveTrueOrderByNameAsc()
                .stream()
                .map(categoryMapper::toResponse)
                .toList();
    }

    public CategoryResponse getById(Long id) {
        return categoryMapper.toResponse(findCategory(id));
    }

    @Transactional
    public CategoryResponse create(CategoryRequest request) {
        String name = request.name().trim();
        if (categoryRepository.existsByNameIgnoreCase(name)) {
            throw new BusinessRuleException("Ya existe una categoría con el nombre '" + name + "'.");
        }
        Category category = categoryMapper.toEntity(request);
        return categoryMapper.toResponse(categoryRepository.save(category));
    }

    @Transactional
    public CategoryResponse update(Long id, CategoryRequest request) {
        Category category = findCategory(id);
        String name = request.name().trim();
        if (categoryRepository.existsByNameIgnoreCaseAndIdNot(name, id)) {
            throw new BusinessRuleException("Ya existe una categoría con el nombre '" + name + "'.");
        }
        categoryMapper.updateEntity(category, request);
        return categoryMapper.toResponse(categoryRepository.save(category));
    }

    @Transactional
    public void deactivate(Long id) {
        Category category = findCategory(id);
        category.setActive(false);
        categoryRepository.save(category);
    }

    @Transactional
    public CategoryResponse activate(Long id) {
        Category category = findCategory(id);
        category.setActive(true);
        return categoryMapper.toResponse(categoryRepository.save(category));
    }

    private Category findCategory(Long id) {
        return categoryRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("No existe la categoría con id " + id + "."));
    }
}
