object fMain: TfMain
  Left = 0
  Top = 0
  Width = 927
  Height = 743
  HorzScrollBar.Style = ssFlat
  VertScrollBar.Style = ssFlat
  AutoScroll = True
  Caption = 'BMPCoordinates'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 519
    Top = 1
    Width = 31
    Height = 13
    Caption = 'Mierka'
  end
  object Label2: TLabel
    Left = 522
    Top = 20
    Width = 34
    Height = 13
    Caption = 'pixelov'
  end
  object bLoad: TButton
    Left = 8
    Top = 8
    Width = 99
    Height = 25
    Caption = 'Na'#269#237'ta'#357' obr'#225'zok'
    TabOrder = 0
    OnClick = bLoadClick
  end
  object bClose: TButton
    Left = 194
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Koniec'
    TabOrder = 1
    OnClick = bCloseClick
  end
  object fitPx: TEdit
    Left = 471
    Top = 14
    Width = 44
    Height = 21
    Alignment = taCenter
    TabOrder = 2
    Text = '10'
    OnChange = fitPxChange
  end
  object fitReal: TEdit
    Left = 554
    Top = 14
    Width = 45
    Height = 21
    Alignment = taCenter
    TabOrder = 3
    Text = '1'
    OnChange = fitRealChange
  end
  object Button1: TButton
    Left = 113
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Prav'#237'tko'
    TabOrder = 4
    OnClick = Button1Click
  end
  object cbUnit: TComboBox
    Left = 605
    Top = 14
    Width = 56
    Height = 21
    ItemHeight = 13
    TabOrder = 5
    Text = 'mm'
    OnChange = cbUnitChange
    Items.Strings = (
      'mm'
      'cm'
      'm')
  end
  object Button2: TButton
    Left = 275
    Top = 6
    Width = 87
    Height = 28
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Kresli stavce'
    TabOrder = 7
    OnClick = KresliStavce
  end
  object Button3: TButton
    Left = 379
    Top = 12
    Width = 64
    Height = 22
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'CS lateral'
    TabOrder = 6
    OnClick = IMGCSlateral
  end
  object Img: TImage32
    Left = 8
    Top = 48
    Width = 817
    Height = 489
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 8
    OnMouseDown = ImgMouseDown
    OnMouseMove = ImgMouseMove
    OnMouseUp = ImgMouseUp
  end
  object Open: TOpenDialog
    Left = 416
    Top = 360
  end
end
