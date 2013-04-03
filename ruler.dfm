object fRuler: TfRuler
  Left = 549
  Top = 300
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Vzdialenos'#357
  ClientHeight = 409
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 177
    Height = 13
    Caption = 'Vzdialenos'#357' posledn'#253'ch dvoch bodov'
  end
  object Label11: TLabel
    Left = 24
    Top = 344
    Width = 49
    Height = 21
    Caption = 'Mierka'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object fPxReal: TLabel
    Left = 107
    Top = 344
    Width = 34
    Height = 21
    Caption = 'pX1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object fit: TLabel
    Left = 107
    Top = 373
    Width = 34
    Height = 21
    Caption = 'pX1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 40
    Width = 283
    Height = 161
    Caption = ' Vzdialenos'#357' v pixeloch na obr'#225'zku'
    TabOrder = 0
    object pX1: TLabel
      Left = 48
      Top = 24
      Width = 34
      Height = 21
      Caption = 'pX1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pY1: TLabel
      Left = 48
      Top = 53
      Width = 33
      Height = 21
      Caption = 'pY1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 24
      Width = 25
      Height = 21
      Caption = 'X1:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 53
      Width = 25
      Height = 21
      Caption = 'Y1:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object pY2: TLabel
      Left = 168
      Top = 53
      Width = 33
      Height = 21
      Caption = 'pY1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pX2: TLabel
      Left = 168
      Top = 24
      Width = 34
      Height = 21
      Caption = 'pX1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 136
      Top = 24
      Width = 25
      Height = 21
      Caption = 'X2:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 136
      Top = 53
      Width = 25
      Height = 21
      Caption = 'Y2:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object dpX: TLabel
      Left = 152
      Top = 98
      Width = 34
      Height = 21
      Caption = 'dpX'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 98
      Width = 108
      Height = 21
      Caption = 'Vzdialenos'#357' X:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object dpY: TLabel
      Left = 152
      Top = 127
      Width = 23
      Height = 21
      Caption = 'dX'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 16
      Top = 127
      Width = 108
      Height = 21
      Caption = 'Vzdialenos'#357' Y:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 207
    Width = 283
    Height = 122
    Caption = ' Vzdialenos'#357' v re'#225'lnych jednotk'#225'ch '
    TabOrder = 1
    object dY: TLabel
      Left = 152
      Top = 55
      Width = 34
      Height = 21
      Caption = 'dpX'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 16
      Top = 24
      Width = 108
      Height = 21
      Caption = 'Vzdialenos'#357' X:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 16
      Top = 53
      Width = 108
      Height = 21
      Caption = 'Vzdialenos'#357' Y:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object dX: TLabel
      Left = 152
      Top = 26
      Width = 23
      Height = 21
      Caption = 'dX'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Left = 16
      Top = 82
      Width = 93
      Height = 21
      Caption = 'Vzdialenos'#357':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object delta: TLabel
      Left = 152
      Top = 84
      Width = 43
      Height = 21
      Caption = 'delta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
