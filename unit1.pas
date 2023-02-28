unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  Menus, StdCtrls, ExtCtrls,BCLabel, bgraControls,BCTypes,
  TAdvancedDropDown,
  BCPanel, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    BCPanel1: TBCPanel;
    ComboBox1: TComboBox;
    procedure ComboBox1MouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  exampleDropDown : TAdvancedDropDown.TAdvancedDropDownList;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  items         : TAdvancedDropDown.TStringArray;
  pPanel        : TBCPanel;


begin
  items         := ['Lorem', 'ipsum', 'dolor', 'sit', 'amet',
                    'consetetur', 'sadipscing', 'elitr', 'sed',
                    'diam nonumy eirmod tempor invidunt',
                    'ut labore et',
                    'dolore', 'magna aliquyam erat',
                    'sed', 'diam', 'voluptua'];

  pPanel        :=    BCPanel1;


  exampleDropDown := TAdvancedDropDown.TAdvancedDropDownList.Create()   ;
  exampleDropDown.Initialize( items);

  exampleDropDown.Render(pPanel);

  // exampleDropDown.example:='hello';
end;

procedure TForm1.ComboBox1MouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin

end;

end.

