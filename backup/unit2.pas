unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  ButtonPanel, db, sqldb, Variants;

type

  { TForm2 }

  TForm2 = class(TForm)
    ButtonPanel1: TButtonPanel;
    StringGrid1: TStringGrid;
  private

  public
    procedure Reload(params: TParams);
    procedure Fill(sql: TSQLQuery);
  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

function FieldTypeToString(t: TFieldType): string;
begin
  if(t = TFieldType.ftString) then
  begin
    FieldTypeToString := 'String';
  end
  else if (t = TFieldType.ftSmallint) or (t = TFieldType.ftInteger) or (t = TFieldType.ftWord) then
  begin
    FieldTypeToString := 'Int';
  end;
end;

procedure TForm2.Reload(params: TParams);
var
  p: TParam;
begin
  while(self.StringGrid1.RowCount > 1) do
  begin
    self.StringGrid1.DeleteRow(1);
  end;
  for p in params do
  begin
    self.StringGrid1.InsertRowWithValues(self.StringGrid1.RowCount, [
      p.Name,
      VarToStr(p.DataType),
      VarToStr(p.Value)
    ]);
  end;
end;

procedure TForm2.Fill(sql: TSQLQuery);
var
  i: integer;
  parameter: TParam;
  k: string;
  typeOfparam: string;
  value: string;
begin
  for i := 1 to self.StringGrid1.RowCount - 1 do
  begin
    k := self.StringGrid1.Rows[i][0];
    typeOfparam := self.StringGrid1.Rows[i][1];
    value := self.StringGrid1.Rows[i][2];
    parameter := sql.Params.ParamByName(k);
    if (typeOfparam = 'Int') then
    begin
      parameter.AsInteger := StrToInt(value);
    end
    else
    begin
      parameter.AsString := value;
    end;
  end;
end;

end.
