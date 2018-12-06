unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, pqconnection, FileUtil, SynHighlighterSQL,
  SynEdit, LR_DBSet, LR_Class, Forms, Controls, Graphics, Dialogs, DBGrids,
  DbCtrls, ComCtrls, StdCtrls, Menus, Unit2, Types,
  fpspreadsheet, fpstypes, xlsbiff8, fpsutils;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSourceRecords: TDataSource;
    DataSourceChilds: TDataSource;
    DataSourceParents: TDataSource;
    DataSourceKindergarteners: TDataSource;
    DataSourceGroups: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    DBGrid5: TDBGrid;
    DBGrid6: TDBGrid;
    DBGrid7: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    DBNavigator3: TDBNavigator;
    DBNavigator4: TDBNavigator;
    DBNavigator5: TDBNavigator;
    frDBDataSetChilds: TfrDBDataSet;
    frDBDataSetGroups: TfrDBDataSet;
    frDBDataSetKindergarteners: TfrDBDataSet;
    frDBDataSetParents: TfrDBDataSet;
    frDBDataSetRecords: TfrDBDataSet;
    ID: TDBText;
    MainMenu1: TMainMenu;
    Export: TMenuItem;
    Import: TMenuItem;
    OpenDialog1: TOpenDialog;
    OpenDialogExcel: TOpenDialog;
    PageControl1: TPageControl;
    PQConnection1: TPQConnection;
    SaveDialog1: TSaveDialog;
    SaveDialogExcel: TSaveDialog;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLQuery3: TSQLQuery;
    SQLQueryRecords: TSQLQuery;
    SQLQueryChilds: TSQLQuery;
    SQLQueryParents: TSQLQuery;
    SQLQueryKindergarteners: TSQLQuery;
    SQLQueryGroups: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    SynEdit1: TSynEdit;
    SynEdit2: TSynEdit;
    SynEdit3: TSynEdit;
    SynSQLSyn1: TSynSQLSyn;
    TabSheet1: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    procedure SaveButtonClick(Sender: TObject);
    procedure SaveAsButtonClick(Sender: TObject);
    procedure OpenButtonClick(Sender: TObject); 
    procedure ExecuteButtonClick(Sender: TObject);
    procedure Execute2ButtonClick(Sender: TObject);
    procedure ParameterButtonClick(Sender: TObject);
    procedure SQLQueryGroupsAfterPost();
    procedure SQLQueryRecordsAfterPost();
    procedure SQLQueryParentsAfterPost();
    procedure SQLQueryChildsAfterPost();
    procedure SQLQueryKindergartenersAfterPost();
    procedure TabSheet9ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);

    procedure ExcelExportMenuItemClick(Sender: TObject);
    procedure ExcelImportMenuItemClick(Sender: TObject);
  private
    procedure RefreshSql();
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.RefreshSql();
begin
  self.SQLQueryGroups.Close();
  self.SQLQueryGroups.Open();
  self.SQLQueryKindergarteners.Close();
  self.SQLQueryKindergarteners.Open();
  self.SQLQueryParents.Close();
  self.SQLQueryParents.Open();
  self.SQLQueryChilds.Close();
  self.SQLQueryChilds.Open();
  self.SQLQueryRecords.Close();
  self.SQLQueryRecords.Open();
end;

procedure TForm1.SQLQueryGroupsAfterPost();
begin
  self.SQLQueryGroups.ApplyUpdates(0);
  self.SQLTransaction1.Commit();
  self.RefreshSql();
end;

procedure TForm1.SQLQueryParentsAfterPost();
begin
  self.SQLQueryParents.ApplyUpdates(0);
  self.SQLTransaction1.Commit();
  self.RefreshSql();
end;

procedure TForm1.SQLQueryChildsAfterPost();
begin
  self.SQLQueryChilds.ApplyUpdates(0);
  self.SQLTransaction1.Commit();
  self.RefreshSql();
end;

procedure TForm1.SQLQueryRecordsAfterPost();
begin
  self.SQLQueryRecords.ApplyUpdates(0);
  self.SQLTransaction1.Commit();
  self.RefreshSql();
end;

procedure TForm1.SQLQueryKindergartenersAfterPost();
begin
  self.SQLQueryKindergarteners.ApplyUpdates(0);
  self.SQLTransaction1.Commit();
  self.RefreshSql();
end;

procedure TForm1.TabSheet9ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm1.SaveButtonClick(Sender: TObject);
begin
  if(self.SaveDialog1.FileName = '') then
  begin
    self.SaveAsButtonClick(Sender);
  end else
  begin
    self.SynEdit1.Lines.SaveToFile(self.SaveDialog1.FileName);
  end;
end;

procedure TForm1.SaveAsButtonClick(Sender: TObject);
var oldFileName: String;
begin
  oldFileName := self.SaveDialog1.FileName;
  if(self.SaveDialog1.Execute()) then
  begin
    self.SynEdit1.Lines.SaveToFile(self.SaveDialog1.FileName);
  end else
  begin
    self.SaveDialog1.FileName := oldFileName;
  end;
end;

procedure TForm1.OpenButtonClick(Sender: TObject);
begin
  if(self.OpenDialog1.Execute()) then
    begin
      self.SaveDialog1.FileName := self.OpenDialog1.FileName;
      self.SynEdit1.Lines.LoadFromFile(self.SaveDialog1.FileName);
    end;
end;

procedure TForm1.ExecuteButtonClick(Sender: TObject);
begin
  self.SQLQuery1.Close();
  self.SQLQuery1.SQL.Text := self.SynEdit1.Text;
  self.SQLQuery1.Open();
end;

procedure TForm1.Execute2ButtonClick(Sender: TObject);
begin
  self.SQLQuery2.Close();
  self.SQLQuery3.Close();
  self.SQLQuery2.SQL.Text := self.SynEdit2.Text;
  self.SQLQuery3.SQL.Text := self.SynEdit3.Text;
  self.SQLQuery3.Open();
  self.SQLQuery2.Open();
end;

procedure TForm1.ParameterButtonClick(Sender: TObject);
var
  form: TForm2;
begin
  Application.CreateForm(TForm2, form);
  self.SQLQuery1.SQL.Text := self.SynEdit1.Text;
  form.Reload(self.SQLQuery1.Params);
  if (form.ShowModal() = 1) then
  begin
    form.Fill(self.SQLQuery1);
  end;
  form.Destroy();
end;

procedure DataSourceToWorksheet(ds: TDataSource; ws: TsWorksheet; header: TStringList);
var
  row, column: Integer;
  ft: TFieldType;
begin
  ds.DataSet.First();
  for column := 0 to header.Count -1 do
  begin
    ws.AddCell(0, column);
    ws.WriteText(0, column, header[column]);
    ws.WriteFontStyle(0, column, [fssBold]);
  end;
  for row := 0 to ds.DataSet.RecordCount - 1 do
  begin
    for column := 0 to ds.DataSet.FieldCount - 1 do
    begin
      ws.AddCell(row + 1, column);
      ft := ds.DataSet.Fields[column].DataType;
      if (ft = ftSmallint) or
         (ft = ftInteger) or
         (ft = ftWord) or
         (ft = ftFloat) or
         (ft = ftCurrency) or
         (ft = ftBCD) or
         (ft = ftLargeint) then
         ws.WriteNumber(row + 1, column,  ds.DataSet.Fields[column].AsFloat)
      else
        ws.WriteText(row + 1, column, ds.DataSet.Fields[column].AsString);
    end;
    ds.DataSet.Next();
  end;
  ds.DataSet.First();
end;

procedure TForm1.ExcelExportMenuItemClick(Sender: TObject);
var
  MyWorkBook: TsWorkbook;
  header: TStringList;
begin
  if(self.SaveDialogExcel.Execute()) then
  begin
    MyWorkBook := TsWorkbook.Create();
    header := TStringList.Create();

    header.Add('ID');
    header.Add('Parent');
    header.Add('Name');
    header.Add('Age');
    header.Add('Gender');
    DataSourceToWorksheet(self.DataSourceChilds, MyWorkBook.AddWorksheet('Childs'), header);

    header.Clear();
    header.Add('ID');
    header.Add('Name');
    header.Add('Count');
    DataSourceToWorksheet(self.DataSourceGroups, MyWorkBook.AddWorksheet('Groups'), header);

    MyWorkBook.WriteToFile(self.SaveDialogExcel.FileName, sfExcel8, True);
  end;
end;

procedure TForm1.ExcelImportMenuItemClick(Sender: TObject);
var
  MyWorkBook: TsWorkbook;
  MyWorksheet: TsWorksheet;
  worksheetIndex: Integer;
  row: Cardinal;
  x : String;
begin
  if(OpenDialogExcel.Execute()) then
  begin
    MyWorkBook := TsWorkbook.Create();
    MyWorkBook.ReadFromFile(OpenDialogExcel.FileName, sfExcel8);

    for worksheetIndex := 0 to MyWorkbook.GetWorksheetCount() - 1 do
    begin
      MyWorksheet := MyWorkbook.GetWorksheetByIndex(worksheetIndex);
      if(MyWorksheet.Name = 'Childs') then
      for row := 1 to MyWorksheet.GetLastRowIndex do
      begin
        if (MyWorksheet.ReadAsText(row, 1) = '') or
           (MyWorksheet.ReadAsText(row, 2) = '') or
           (MyWorksheet.ReadAsText(row, 3) = '') or
           (MyWorksheet.ReadAsText(row, 4) = '') then
           continue;
        self.DataSourceChilds.DataSet.Insert();
        self.DataSourceChilds.DataSet.Fields[1].AsInteger := Int64(MyWorksheet.ReadAsNumber(row, 1)); // parent_id
        self.DataSourceChilds.DataSet.Fields[2].AsString := MyWorksheet.ReadAsText(row, 2); // name
        self.DataSourceChilds.DataSet.Fields[3].AsInteger := Int64(MyWorksheet.ReadAsNumber(row, 3)); // age
        self.DataSourceChilds.DataSet.Fields[4].AsString := MyWorksheet.ReadAsText(row, 4); // gender
      end;
      if(MyWorksheet.Name = 'Groups') then
      for row := 1 to MyWorksheet.GetLastRowIndex do
      begin
        x := MyWorksheet.ReadAsText(row, 1);
        x := MyWorksheet.ReadAsText(row, 2);

        if (MyWorksheet.ReadAsText(row, 1) = '') or
           (MyWorksheet.ReadAsText(row, 2) = '') then
           continue;
        self.DataSourceGroups.DataSet.Insert();
        self.DataSourceGroups.DataSet.Fields[1].AsString := MyWorksheet.ReadAsText(row, 1); // name
        self.DataSourceGroups.DataSet.Fields[2].AsInteger := Int64(MyWorksheet.ReadAsNumber(row, 2)); // max_count
      end;
    end;
  end;

  if(self.DataSourceChilds.DataSet.State = dsInsert) then
  self.DataSourceChilds.DataSet.Post();
  if(self.DataSourceGroups.DataSet.State = dsInsert) then
  self.DataSourceGroups.DataSet.Post();
end;

end.
