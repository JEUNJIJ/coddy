package com.kh.coddy.board.free.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Fattachment {
			
    private int fattachmentNo;			// 파일번호
    private int fboardNo;				// 게시글 번호
    private String fattachmentOrigin;	// 원본 파일명
    private String fattachmentChange;
    private String fattachmentPath;
    private String fattachmentInsert;
    private int fattachmentLevel;
	
}
