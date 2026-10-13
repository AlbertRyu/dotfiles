# 定义一个名为 blogimg 的 fish 函数；--description 是在补全和 `functions` 列表里显示的说明
function blogimg --description 'Convert one image to blog-ready WebP and delete the original'

    # $argv[1] 是传进来的第一个参数，也就是要处理的图片路径（fish 的列表从 1 开始编号）
    # path change-extension webp ... 把文件扩展名换成 .webp，例如 IMG_1234.HEIC → IMG_1234.webp
    # set -l 定义一个局部变量 out，只在这个函数里有效，保存输出文件名
    set -l out (path change-extension webp $argv[1])

    # 如果输出文件名和输入文件名相同（说明原图已经是 .webp），
    # 就打印提示到标准错误（>&2），并以状态 1（失败）退出函数，
    # 避免后面的 rm 把唯一的文件删掉
    test "$out" = "$argv[1]"; and echo "已经是 WebP" >&2; and return 1

    # 用 ImageMagick 转换图片，各参数依次是：
    #   $argv[1]                  输入文件
    #   -auto-orient              按照片里记录的拍摄方向把图片摆正
    #   -strip                    删除 EXIF 等元数据（包括 GPS 位置）
    #   -colorspace sRGB          转成网页标准色彩空间 sRGB（iPhone 照片默认是 Display P3）
    #   -resize '1600x1600>'      长边缩到不超过 1600 像素；'>' 表示只缩小、不放大
    #   -quality 80               压缩质量 80（0–100，越高越清晰、文件越大）
    #   $out                      输出文件；ImageMagick 根据 .webp 扩展名自动选择格式
    magick $argv[1] -auto-orient -strip -colorspace sRGB -resize '1600x1600>' -quality 80 $out

    # and 表示只有上一条命令成功（退出状态为 0）才执行：
    # 转换成功后删除原图；转换失败则原图保留
    and rm $argv[1]

    # 删除也成功后，打印生成的文件名
    and echo "→ $out"

    # 函数定义结束
end
