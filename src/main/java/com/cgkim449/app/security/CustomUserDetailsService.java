package com.cgkim449.app.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import com.cgkim449.app.domain.MemberVO;
import com.cgkim449.app.mapper.MemberMapper;
import com.cgkim449.app.security.domain.CustomUser;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

  // 껍데기
  //  @Setter(onMethod_ = { @Autowired })
  //  private MemberMapper memberMapper;
  //
  //  @Override
  //  public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
  //
  //    log.warn("Load User By UserName : " + userName);
  //
  //    return null;
  //  } 

  @Setter(onMethod_ = { @Autowired })
  private MemberMapper memberMapper;

  @Override
  public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {

    log.warn("Load User By UserName : " + userName);

    // loadUserByUsernamer()은 내부적으로 MemberMapper를 이용해서 MemberVO를 조회하고, 
    // userName means userid
    MemberVO vo = memberMapper.read(userName);

    log.warn("queried by member mapper: " + vo);

    // 만일 MemberVO의 인스턴스를 얻을 수 있다면 CustomUser타입의 객체로 변환해서 반환한다
    return vo == null ? null : new CustomUser(vo);
  } 

}
