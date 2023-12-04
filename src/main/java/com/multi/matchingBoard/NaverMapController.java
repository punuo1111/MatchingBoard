package com.multi.matchingBoard;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NaverMapController {

    @GetMapping(value = "/naverMap")
    public String naverMap() {
        return "matchingRoom/naverMap";
    }

}
