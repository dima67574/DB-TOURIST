package com.db.tourist.repositories;

import com.db.tourist.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByLogin(String login);
    User findByEmail(String email);
    User findByToken(String token);
    User findByPhoneNumber(String phone);
}