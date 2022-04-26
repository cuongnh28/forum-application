package com.fc.service;

import java.io.IOException;

import com.fc.util.MyConstant;
import com.qiniu.http.Response;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import org.springframework.stereotype.Service;

@Service
public class QiniuService {
    private String ACCESS_KEY = MyConstant.QINIU_ACCESS_KEY;
    private String SECRET_KEY = MyConstant.QINIU_SECRET_KEY;
    private String BUCKET_NAME = MyConstant.QINIU_BUCKET_NAME;
    private Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
    private UploadManager uploadManager = new UploadManager();

    public String getUpToken() {
        return auth.uploadToken(BUCKET_NAME);
    }

    public void upload(byte[] localData, String remoteFileName) throws IOException {
        Response res = uploadManager.put(localData, remoteFileName, getUpToken());
        System.out.println(res.bodyString());
    }

}
