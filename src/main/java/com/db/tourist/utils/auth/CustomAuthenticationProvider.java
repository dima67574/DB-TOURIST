package com.db.tourist.utils.auth;

import com.db.tourist.models.User;
import com.db.tourist.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    UserService userService;

    @Autowired
    Md5PasswordEncoder encoder;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {

        User user = userService.findByLogin(authentication.getName());

        //если данные входа не верны
        if (user == null || !encoder.isPasswordValid(user.getPassword(), authentication.getCredentials().toString(), null)) {
            throw new BadCredentialsException("Неверный логин или пароль");
        }

        //если заблокирован
        if (user.getBanned()) {
            throw new BadCredentialsException("Ваш аккаунт заблокирован");
        }

        UserPrincipal principal = userService.makeUserPrincipal(user);
        return new UsernamePasswordAuthenticationToken(principal, authentication.getCredentials(), principal.getAuthorities());
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}