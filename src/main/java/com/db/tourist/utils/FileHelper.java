package com.db.tourist.utils;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.Instant;

@Component
public class FileHelper {

    @Autowired
    private ServletContext context;

    private String uploadFolder = "/upload";

    public String upload(MultipartFile file) {
        Instant instant = Instant.now();
        String fileName = Long.toHexString(instant.toEpochMilli() + file.getOriginalFilename().hashCode());
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
        fileName = fileName + "." + ext;
        String filePath = getUploadPath() + fileName;
        String thumbFilePath = getUploadPath() + "thumb_" + fileName;

        try {
            File imageFile = new File(filePath);
            file.transferTo(imageFile);

            //миниатюра
            BufferedImage img = ImageIO.read(imageFile);
            BufferedImage scaledImg = Scalr.resize(img, 230);
            ImageIO.write(scaledImg, ext, new File(thumbFilePath));
        } catch (IOException e) {
            e.printStackTrace();
        }

        return fileName;
    }

    public void getFile(HttpServletResponse response, String name) throws IOException {
        if (name != null) {
            try {
                File imageFile = new File(getUploadPath() + name);
                InputStream is = new FileInputStream(imageFile);
                IOUtils.copy(is, response.getOutputStream());
                is.close();
            } catch(IOException e) {
            }
        }
    }

    public Boolean delete(String file) {
        if (file != null) {
            try {
                Files.delete(Paths.get(getUploadPath() + file));
                File fileCheck = new File(getUploadPath() + file);
                boolean exists = fileCheck.exists();
                Files.delete(Paths.get(getUploadPath() + "thumb_" + file));
                File thumbCheck = new File(getUploadPath() + "thumb_" + file);
                boolean thumbExists = thumbCheck.exists();
                if (!exists && !thumbExists) {
                    return true;
                }
            } catch (Exception e) {
                return false;
            }
        }
        return false;
    }

    public String getUploadPath() {
        return context.getRealPath(uploadFolder) + "\\";
    }
}
