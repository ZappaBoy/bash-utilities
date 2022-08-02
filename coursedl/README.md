# coursedl
This simple script help to download udemy courses to which you have access.

# Acknowledgements
Thanks to [youtube-dl](https://github.com/ytdl-org/youtube-dl) that helps to download the videos
and to [dandv](https://github.com/dandv/convert-chrome-cookies-to-netscape-format) to convert cookies in netscape format.

# Instructions
## Downlaod youtube-dl
Check [youtube-dl](https://github.com/ytdl-org/youtube-dl) to download instructions.

## Copy your udemy cookies from google developer console to `udemy-cookies.txt`
1. Open Google Chrome
2. Go to [udemy](https://www.udemy.com/) and login
3. After logged open developer console (F12)
4. Go to Application > Storage > Cookies > Select udemy cookies
5. Copy the table with cookies entirely
6. Paste the content in `udemy-cookies.txt`
7. Replace entirely the content removing the instructions
For other information check: [convert-chrome-cookies-to-netscape-format](https://github.com/dandv/convert-chrome-cookies-to-netscape-format)

## Run the script
Go to you course link and pass only the course name from the url as parameter.
Example:

``` text
Course Url: https://www.udemy.com/course/social-media-marketing-il-corso-completo-con-certificato/
Copy only "social-media-marketing-il-corso-completo-con-certificato"
```

Run the script passing the course name as argument

``` shell
./coursedl "social-media-marketing-il-corso-completo-con-certificato"
```

