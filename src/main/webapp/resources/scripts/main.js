function captch_refresh(el) {
    var src = $(el).attr('src');
    if (src) {
        var queryPos = src.indexOf('?');
        if (queryPos != -1) {
            src = src.substring(0, queryPos);
        }
    } else {
        src = "/captcha";
    }
    $(el).attr('src', src + '?' + Math.random());
    return false;
}