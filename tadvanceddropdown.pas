unit TAdvancedDropDown;

{$mode ObjFPC}{$H+}{$modeswitch advancedrecords}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls, ExtCtrls,BCLabel, bgraControls,BCTypes, math, BCPanel;

type

  TProc          = procedure(AParm: TObject) of object;
  TStringArray = Array of String;

  { TAdvancedDropDownList }

  TAdvancedDropDownList = Class

    public
      currPos   : Integer;
      items     : TStringArray;

      renderContainer : TBCPanel;
      dropDown        : TBCPanel;

      containerHeight : Integer;
      containerWidth  : Integer;
      containerColor  : TColor;
      containerBorderColor : TColor;
      containerFontColors : Array of TColor;
      containerBorderWidth : Integer;
      containerFontNames   : Array of String;
      containerFontSizes   : Array of Integer;
      containerFontStyles   : Array of Integer;
      containerFontBackGrounds : Array of TColor;

      selectedItem : Integer;

      dropDownOn   : Boolean;
      dropDownWidth: Integer;
      dropDownHeight:Integer;

      constructor Create();

      procedure Initialize(entryItems: TStringArray);
      procedure Render(pPanel : TBCPanel);
      procedure toggleDropDown(Sender : TObject) ;
      procedure scrollDropDownPanel(Sender: TObject; Shift: TShiftState;  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);




  end;

implementation

{ TAdvancedDropDownList }

constructor TAdvancedDropDownList.Create;

begin




  // containerHeight := Floor(0.5 * Length(items)) * 1;


end;

procedure TAdvancedDropDownList.Initialize(entryItems: TStringArray);
var

  i             : Integer;
begin


  renderContainer := TBCPanel.Create(Nil);
  renderContainer.Parent := Nil;



  setLength(items, 0);
  items         := entryitems;

  selectedItem := 0;

  containerColor  := clForm;
  containerBorderColor := clGrayText;

  SetLength( containerFontColors, 0);
  for i := 0 to Length(items) - 1 do
  begin
    SetLength( containerFontColors, Length(containerFontColors) + 1);
    containerFontColors[Length(containerFontColors) - 1] := clWindowText;
  end;


  containerBorderColor := clGrayText;
  containerBorderWidth := 1;


  SetLength( containerFontNames, 0);
  for i := 0 to Length(items) - 1 do
  begin
    SetLength( containerFontNames, Length(containerFontNames) + 1);
    containerFontNames[Length(containerFontNames) - 1] := Screen.SystemFont.Name;
  end;



  SetLength( containerFontSizes, 0);
  for i := 0 to Length(items) - 1 do
  begin
    SetLength( containerFontSizes, Length(containerFontSizes) + 1);
    containerFontSizes[Length(containerFontSizes) - 1] := 0;
  end;


  SetLength( containerFontStyles, 0);
  for i := 0 to Length(items) - 1 do
  begin
    SetLength( containerFontStyles, Length(containerFontStyles) + 1);
    containerFontStyles[Length(containerFontStyles) - 1] := 0;
  end;


  SetLength( containerFontBackGrounds, 0);
  for i := 0 to Length(items) - 1 do
  begin
    SetLength( containerFontBackGrounds, Length(containerFontBackGrounds) + 1);
    containerFontBackGrounds[Length(containerFontBackGrounds) - 1] := clForm;
  end;

  dropDownOn    := False;

  dropDownWidth := -1;
  dropDownHeight:= -1;
  {TODO : Implement bevel controls}
end;



procedure TAdvancedDropDownList.Render(pPanel: TBCPanel);
var
  mPanel          : TBCPanel;
begin


  //---------------   Attach the top Panel to the container    -------------------//

  // mPanel        := TBCPanel.Create(Nil);
  renderContainer.Parent := pPanel;



  renderContainer.Caption:= items[selectedItem];

  renderContainer.FontEx.Color:= containerFontColors[selectedItem] ;

  renderContainer.Height := pPanel.Height;
  renderContainer.Width  := pPanel.Width ;

  renderContainer.BevelOuter:=bvNone;

  renderContainer.Color:= containerColor;

  renderContainer.Border.Color:= containerBorderColor;
  renderContainer.Border.Width:= containerBorderWidth;

  renderContainer.Border.Style:=bboSolid;
  renderContainer.BorderBCStyle:= bpsBorder;

  renderContainer.Rounding.RoundX:=5;
  renderContainer.Rounding.RoundY:=5;

  mPanel := TBCPanel.Create(renderContainer);
  mPanel.Parent := renderContainer;

  mPanel.Height := renderContainer.Height - 4;
  mPanel.Top    := 2;

  mPanel.Width  := mPanel.Height;
  renderContainer.FontEx.PaddingRight:= mPanel.Width + 2;
  renderContainer.FontEx.TextAlignment:=bcaCenter;
  mPanel.Caption:='ᐯ';
  mPanel.Left   := renderContainer.Width - mPanel.Width - 2;

  mPanel.BevelOuter:=bvNone;

  mPanel.FontEx.Color:=clWindowText;
  mPanel.OnClick:= @toggleDropDown;



end;

procedure TAdvancedDropDownList.toggleDropDown(Sender: TObject);
var
  i             : Integer;
  c             : TBitmap;
  cPanel        : TBCPanel;
  cpanels       : Array of TBCPanel;
  totalHeight   : Integer;

  maxWidth      : Integer;

  fnt           : TFont;
begin
  if not dropDownOn then
  begin
    dropDown := TBCPanel.Create((Sender as TBCPanel).Parent.Parent.Parent);
    dropDown.Parent := (Sender as TBCPanel).Parent.Parent.Parent;


    dropDown.Top:=((Sender as TBCPanel).Parent.Parent as TBCPanel).Top + ((Sender as TBCPanel).Parent.Parent as TBCPanel).Height;
    dropDown.Left:=((Sender as TBCPanel).Parent.Parent as TBCPanel).Left;

    dropDown.BevelOuter:=bvNone;

    totalHeight := 0;

    SetLength(cPanels, 0);


    maxWidth    := 0;

    for i := 0 to Length(items) - 1 do
    begin
      cPanel    := TBCPanel.Create(dropDown);
      cPanel.Parent := dropDown;


      fnt       := TFont.Create;
      fnt.Name  := containerFontNames[i];

      cPanel.Height := fnt.GetTextHeight('AyTg') + 4;

      c := TBitmap.Create;
      c.Canvas.Font.Assign(fnt);
      cPanel.Width  := c.Canvas.TextWidth(items[i]) + 4; //---------------------// Label width

      // showMessage( IntToStr (      c.Canvas.TextWidth(items[i])     ) + ' -- ' + IntToStr(i));

      c.Free;

      cPanel.Caption:= items[i];
      cPanel.BevelOuter:=bvNone;

      cPanel.FontEx.Color:= containerFontColors[i];
      cPanel.FontEx.TextAlignment:=bcaLeftCenter;
      cPanel.FontEx.PaddingLeft:=2;
      cPanel.Color:= containerFontBackGrounds[i];
      cPanel.Left := 2;
      cPanel.Top  := totalHeight+2;

      totalHeight:= totalHeight + cPanel.Height+2;

      SetLength(cPanels, Length(cPanels) + 1);

      cPanel.OnMouseWheel := @scrollDropDownPanel;

      cPanels[Length(cPanels) - 1] := cPanel;

      if maxWidth < cPanel.Width then
      begin
        maxWidth := cPanel.Width;
      end;


    end;





    for i := 0 to Length(cPanels) - 1 do
    begin
      cPanels[i].Width:=maxWidth;
    end;




    dropDown.Height:=totalHeight+2;

    dropDown.Border.Color:= containerBorderColor;
    dropDown.Border.Width:= containerBorderWidth;

    dropDown.Border.Style:=bboSolid;
    dropDown.BorderBCStyle:= bpsBorder;

    dropDown.Rounding.RoundX:=5;
    dropDown.Rounding.RoundY:=5;

    dropDown.Width:= maxWidth+4;
    dropDown.Visible:=True;



    if (dropDownWidth <> -1) then
    begin
      dropDown.Width:=dropDownWidth;
    end;

    if (dropDownHeight <> -1) then
    begin
      dropDown.Height:=dropDownHeight;
    end;

    dropDown.Height := Floor(dropDown.Height div 2)  ;


    dropDownOn      := True;

  end
  else
  begin
    dropDown.Visible:=False;
    dropDownOn      :=False;
  end;
end;

procedure TAdvancedDropDownList.scrollDropDownPanel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  ShowMessage('hello');
end;

end.

