package com.koreait.day02.repository;

import com.koreait.day02.model.entity.AdminUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository //class가 아니라 interface로 상속받아야함 //인터페이스를 상속받아 사용
public interface AdminUserRepository extends JpaRepository<AdminUser, Long> {
                    //dto에 저장된 데이터들을 JPA를 사용하여 JpaRepository 객체를 만들먄 이 객체에 데이터가 자동으로 저장
                    //데이터 테이블과 연결시킬 테이블(Entity),구분할 필드의 타입(long)
}
