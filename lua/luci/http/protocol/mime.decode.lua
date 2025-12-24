local L0, L1, L2
L0 = module
L1 = "luci.http.protocol.mime"
L2 = package
L2 = L2.seeall
L0(L1, L2)
L0 = require
L1 = "luci.util"
L0(L1)
L0 = {}
L0.txt = "text/plain"
L0.js = "text/javascript"
L0.css = "text/css"
L0.htm = "text/html"
L0.html = "text/html"
L0.patch = "text/x-patch"
L0.c = "text/x-csrc"
L0.h = "text/x-chdr"
L0.o = "text/x-object"
L0.ko = "text/x-object"
L0.bmp = "image/bmp"
L0.gif = "image/gif"
L0.png = "image/png"
L0.jpg = "image/jpeg"
L0.jpeg = "image/jpeg"
L0.svg = "image/svg+xml"
L0.zip = "application/zip"
L0.pdf = "application/pdf"
L0.xml = "application/xml"
L0.xsl = "application/xml"
L0.doc = "application/msword"
L0.ppt = "application/vnd.ms-powerpoint"
L0.xls = "application/vnd.ms-excel"
L0.odt = "application/vnd.oasis.opendocument.text"
L0.odp = "application/vnd.oasis.opendocument.presentation"
L0.pl = "application/x-perl"
L0.sh = "application/x-shellscript"
L0.php = "application/x-php"
L0.deb = "application/x-deb"
L0.iso = "application/x-cd-image"
L0.tgz = "application/x-compressed-tar"
L0.mp3 = "audio/mpeg"
L0.ogg = "audio/x-vorbis+ogg"
L0.wav = "audio/x-wav"
L0.mpg = "video/mpeg"
L0.mpeg = "video/mpeg"
L0.avi = "video/x-msvideo"
MIME_TYPES = L0
function L0(A0)
  local L1, L2, L3, L4
  L1 = type
  L2 = A0
  L1 = L1(L2)
  if L1 == "string" then
    L2 = A0
    L1 = A0.match
    L3 = "[^%.]+$"
    L1 = L1(L2, L3)
    if L1 then
      L2 = MIME_TYPES
      L4 = L1
      L3 = L1.lower
      L3 = L3(L4)
      L2 = L2[L3]
      if L2 then
        L2 = MIME_TYPES
        L4 = L1
        L3 = L1.lower
        L3 = L3(L4)
        L2 = L2[L3]
        return L2
      end
    end
  end
  L1 = "application/octet-stream"
  return L1
end
to_mime = L0
function L0(A0)
  local L1, L2, L3, L4, L5, L6
  if L1 == "string" then
    for L4, L5 in L1, L2, L3 do
      if L5 == A0 then
        return L4
      end
    end
  end
  return L1
end
to_ext = L0
