package firstWeb.board.dtos;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@NoArgsConstructor
@AllArgsConstructor
@Data
public class BoardDTO {
    private int  num;
    private String Writer;
    private String subject;
    private String content;
    private String pw;
    private Timestamp reg_date;
    private int read_count;
    private String ip;
    private int ref; // 글의 그룹을 나타내는 번호
    private int re_step; // 그룹 내의 제목 및 댓글 순서
    private int re_level; // 글 제목이 화면에서 표현 될 때 들여쓰기 값 변수
    
    
}
