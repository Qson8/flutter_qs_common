import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qs_common/qs_common/base/base.dart';


/// @author Qson
/// @create 2019/12/17
/// @Describe Text widget
class NormalText extends Text{//正文字体
  NormalText(String data) : super(data,style:textStyle.normalText);
}

class NormalTextDark extends Text{//正文字体
  NormalTextDark(String data) : super(data,style:textStyle.normalTextDark);
}

class NormalWhiteText extends Text{//正文字体
  NormalWhiteText(String data) : super(data,style:textStyle.normalTextWhite);
}

class MiddleText extends Text{
  MiddleText(String data):super(data,style:textStyle.middleText);
}
class MiddleTextDark extends Text{
  MiddleTextDark(String data):super(data,style:textStyle.middleTextDark);
}
class MiddleWhiteText extends Text{
  MiddleWhiteText(String data):super(data,style:textStyle.middleTextWhite);
}

class LargeText extends Text{//标题字体
  LargeText(String data) : super(data,style:textStyle.largeText);
}

class LargeTextBold extends Text{
  LargeTextBold(String data) : super(data,style:textStyle.largeTextBold);
}

class LargeLargeText extends Text{//大字体
  LargeLargeText(String data) : super(data,style:textStyle.largeLargeText);
}

class BigLargeText extends Text{//超大大字体
  BigLargeText(String data) : super(data,style:textStyle.bigLargeText);
}

class SmallText extends Text{//小字体
  SmallText(String data) : super(data,style:textStyle.smallText);
}

class SmallWhiteText extends Text{//小字体
  SmallWhiteText(String data) : super(data,style:textStyle.smallTextWhite);
}

class SmallTextDark extends Text{//小字体
  SmallTextDark(String data) : super(data,style:textStyle.smallTextDark);
}

class SmallTextDarkLike extends Text{//小字体
  SmallTextDarkLike(String data) : super(data,style:textStyle.smallTextDarkLike);
}

class MinText extends Text{//小字体
  MinText(String data) : super(data,style:textStyle.minText);
}

class MinTextWhite extends Text{//小字体
  MinTextWhite(String data) : super(data,style:textStyle.smallMiLightText);
}


class MinTextDark extends Text{
  MinTextDark(String data) : super(data,style:textStyle.minTextDark);
}

class MinTextDarkLike extends Text{
  MinTextDarkLike(String data) : super(data,style:textStyle.minTextDarkLike);
}

class MinTextPri extends Text{//小字体主题风格
  MinTextPri(String data) : super(data,style:textStyle.minTextPri);
}

///上下按钮控件
class TextWithIcon {

  static Widget of({tag,Widget icon,Widget text}){

    return GestureDetector(
      onTap:tag,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon,
        SizedBox(width:0,height:size.small_padding,),
        text,
      ],
    ),);
  }



}





