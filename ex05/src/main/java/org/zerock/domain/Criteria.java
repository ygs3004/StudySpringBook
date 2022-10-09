package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.util.UriComponentsBuilder;

@ToString
@Setter
@Getter
public class Criteria {

    private int pageNum;
    private int amount;

    private String type;
    private String keyword;

    public Criteria() {
        this(1, 10);
    }

    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public String[] getTypeArr() {

        return type == null? new String[] {}: type.split("");
    }

    public String getListLink(){
        // Criteria 데이터로 링크를 만들어줌 ex) ?pageNum=3&amount=20&type=TC&keyword=%EC~~~~~~~~~
        UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
                .queryParam("pageNum", this.pageNum)
                .queryParam("amount", this.getAmount())
                .queryParam("pageNum", this.getType())
                .queryParam("pageNum", this.getKeyword());

        return builder.toUriString();
    }

}