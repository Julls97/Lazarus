unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, pqconnection, FileUtil, SynHighlighterSQL,
  SynEdit, Forms, Controls, Graphics, Dialogs, DBGrids, DbCtrls, ComCtrls,
  StdCtrls, Menus, Unit2;

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
    ID: TDBText;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    PQConnection1: TPQConnection;
    SaveDialog1: TSaveDialog;
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

end.
