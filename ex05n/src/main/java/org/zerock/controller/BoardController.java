package org.zerock.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@Log4j
@RequestMapping("/board")
@AllArgsConstructor
public class BoardController {

    private BoardService service;

    @GetMapping("/list")
    public void list(Criteria cri, Model model){
        log.info("list : "+cri);
        model.addAttribute("list", service.getList(cri));
        //model.addAttribute("pageMaker",new PageDTO(cri,123));
        int total = service.getTotal(cri);

        log.info("total: " + total);

        model.addAttribute("pageMaker", new PageDTO(cri, total));
    }

    @GetMapping("/register")
    public void register(){

    }

    @PostMapping("/register")
    public String register(BoardVO board, RedirectAttributes rttr){

        log.info("=========================================");
        log.info("register : "+board);
        if(board.getAttachList() != null){
            board.getAttachList().forEach(attach -> log.info(attach));
        }
        log.info("=========================================");

        service.register(board);
        rttr.addFlashAttribute("result", board.getBno());
        return "redirect:/board/list";
    }

    @GetMapping({"/get", "/modify"})
    public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model){
        log.info("/get or modify");
        model.addAttribute("board", service.get(bno));
    }

    @PostMapping("/modify")
    public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr){
        log.info("modify : "+board);

        if(service.modify(board)){
            rttr.addFlashAttribute("result", "success");
        }
        /*
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("type", cri.getType());
        rttr.addAttribute("keyword", cri.getKeyword());
        return "redirect:/board/list";
        */
        return "redirect:/board/list" + cri.getListLink();
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr){
        log.info("remove...........");

        List<BoardAttachVO> attachList = service.getAttachList(bno);

        if(service.remove(bno)){

            deleteFiles(attachList);

            rttr.addFlashAttribute("result", "success");
        }

        /* /board/list" + cri.getListLink();
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("type", cri.getType());
        rttr.addAttribute("keyword", cri.getKeyword());
        return "redirect:/board/list";
        */

        return "redirect:/board/list" + cri.getListLink();
    }

    @GetMapping(value = "/getAttachList",
        produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
        log.info("getAttachList" + bno);
        return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
    }

    private void deleteFiles(List<BoardAttachVO> attachList){
        if(attachList == null || attachList.size() == 0){
            return;
        }

        log.info("delete attach files........................");
        log.info(attachList);

        attachList.forEach( attach -> {

            try{
                Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());

                Files.deleteIfExists(file);

                if(Files.probeContentType(file).startsWith("image")){

                    Path thumNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());

                    Files.delete(thumNail);
                }

            }catch (Exception e){
                log.error("delete file error" + e.getMessage());
            } // end catch

        }); // end forEach
    }
}