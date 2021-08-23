package com.koreait.day03.model.network.response;

import com.koreait.day03.model.enumclass.DtUserStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserApiResponse {

    private Long id;
    private String userid;
    private String userpw;
    private String hp;
    private String email;
    private LocalDateTime regDate;
    private DtUserStatus status;

}
