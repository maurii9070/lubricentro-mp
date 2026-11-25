package com.lubricentromp.api.controller;

import com.lubricentromp.api.dto.DailyClosingReportResponse;
import com.lubricentromp.api.enums.Shift;
import com.lubricentromp.api.service.ReportService;
import java.time.LocalDate;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/reports")
public class ReportController {

    private final ReportService reportService;

    public ReportController(ReportService reportService) {
        this.reportService = reportService;
    }

    @GetMapping("/daily-closing")
    public DailyClosingReportResponse getDailyClosingReport(
            @RequestParam("date")
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @RequestParam(name = "shift", required = false) Shift shift
    ) {
        return reportService.getDailyClosingReport(date, shift);
    }
}
