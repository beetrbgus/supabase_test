enum FileMimeType {
  // Image MIME Type
  imageAll('image/*', '모든 이미지 파일 형식'),
  imageJpeg('image/jpeg', 'JPEG 이미지 파일'),
  imagePng('image/png', 'PNG 이미지 파일'),
  imageGif('image/gif', 'GIF 이미지 파일'),
  imageWebp('image/webp', 'WebP 이미지 파일'),
  imageSvgXml('image/svg+xml', 'SVG 이미지 파일'),

  // Video MIME Types
  videoAll('video/*', '모든 비디오 파일 형식'),
  videoMp4('video/mp4', 'MP4 비디오 파일'),
  videoWebm('video/webm', 'WebM 비디오 파일'),
  videoMatroska('video/x-matroska', 'Matroska 비디오 파일 (MKV)'),
  videoOgg('video/ogg', 'Ogg 비디오 파일'),

  // Audio MIME Types
  audioAll('audio/*', '모든 오디오 파일 형식'),
  audioMpeg('audio/mpeg', 'MP3 오디오 파일'),
  audioOgg('audio/ogg', 'Ogg 오디오 파일'),
  audioWav('audio/wav', 'WAV 오디오 파일'),
  audioWebm('audio/webm', 'WebM 오디오 파일'),

  // Text MIME Types
  textAll('text/*', '모든 텍스트 파일 형식'),
  textPlain('text/plain', '일반 텍스트 파일'),
  textHtml('text/html', 'HTML 파일'),
  textCss('text/css', 'CSS 파일'),
  textJavascript('text/javascript', 'JavaScript 파일'),

  // Application MIME Types
  applicationAll('application/*', '모든 애플리케이션 파일 형식'),
  applicationJson('application/json', 'JSON 파일'),
  applicationPdf('application/pdf', 'PDF 파일'),
  applicationZip('application/zip', 'ZIP 압축 파일'),
  applicationMsExcel('application/vnd.ms-excel', 'Excel 파일 (XLS)'),
  applicationOpenXmlExcel(
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'Excel 파일 (XLSX)'),
  applicationMsWord('application/msword', 'Word 파일 (DOC)'),
  applicationOpenXmlWord(
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'Word 파일 (DOCX)'),

  // 기타 형식
  applicationOctetStream('application/octet-stream', '바이너리 데이터 파일'),
  multipartFormData('multipart/form-data', '폼 데이터 (파일 업로드 시 사용)');

  final String value;
  final String desc;

  const FileMimeType(this.value, this.desc);

  @override
  String toString() => value;
}
