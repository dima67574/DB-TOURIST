package com.db.tourist.services;

import java.util.List;

public interface SettingsService {
    Boolean savePreferences(List<Long> epochs, List<Long> types, List<Long> styles);

    Boolean saveEmail(String email);
}
