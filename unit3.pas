unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dbf, db, sqldb, pqconnection, FileUtil, TADbSource,
  LR_Class, LR_DBSet, LR_BarC, LR_View, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Menus, TACustomSource, TAGraph, TASeries;

type

  { TForm3 }

  TForm3 = class(TForm)
    Chart1: TChart;
    Chart1BarSeries1: TBarSeries;
    Chart2: TChart;
    DataSourceChilds: TDataSource;
    DataSourceChildsChart: TDataSource;
    DataSourceGroups: TDataSource;
    DataSourceKindergarteners: TDataSource;
    DataSourceParents: TDataSource;
    DataSourceRecords: TDataSource;
    DbChartSourceChilds: TDbChartSource;
    DbChartSourceGroups: TDbChartSource;
    DbChartSourceKindergarteners: TDbChartSource;
    DbChartSourceParents: TDbChartSource;
    DbChartSourceRecords: TDbChartSource;
    frDBDataSetChilds: TfrDBDataSet;
    frDBDataSetGroups: TfrDBDataSet;
    frDBDataSetKindergarteners: TfrDBDataSet;
    frDBDataSetParents: TfrDBDataSet;
    frDBDataSetRecords: TfrDBDataSet;
    frReportChilds: TfrReport;
    frReportGroups: TfrReport;
    frReportKindergarteners: TfrReport;
    frReportParents: TfrReport;
    frReportRecords: TfrReport;
    MainMenu1: TMainMenu;
    ChildsReport: TMenuItem;
    ParentsReport: TMenuItem;
    GroupsReport: TMenuItem;
    KindergartenersReport: TMenuItem;
    RecordsReport: TMenuItem;
    PQConnection1: TPQConnection;
    SQLQueryChilds: TSQLQuery;
    SQLQueryChildsChart: TSQLQuery;
    SQLQueryGroups: TSQLQuery;
    SQLQueryKindergarteners: TSQLQuery;
    SQLQueryParents: TSQLQuery;
    SQLQueryRecords: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure ChildsReportMenuItemClick(Sender: TObject);
    procedure DbChartSourceParentsGetItem(ASender: TDbChartSource;
      var AItem: TChartDataItem);
    procedure ParentsReportMenuItemClick(Sender: TObject);
    procedure GroupsReportMenuItemClick(Sender: TObject);
    procedure KindergartenersReportMenuItemClick(Sender: TObject);
    procedure RecordsReportMenuItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    procedure RefreshSql();
  public

  end;

var
  Form3: TForm3;

implementation

{$R *.lfm}

{ TForm3 }

procedure TForm3.ChildsReportMenuItemClick(Sender: TObject);
begin
  self.frReportChilds.LoadFromFile('report_childs.lrf');
  self.frReportChilds.ShowReport();
end;

procedure TForm3.DbChartSourceParentsGetItem(ASender: TDbChartSource;
  var AItem: TChartDataItem);
begin

end;

procedure TForm3.ParentsReportMenuItemClick(Sender: TObject);
begin
  self.frReportParents.LoadFromFile('report_parents.lrf');
  self.frReportParents.ShowReport();
end;

procedure TForm3.GroupsReportMenuItemClick(Sender: TObject);
begin
  self.frReportGroups.LoadFromFile('report_groups.lrf');
  self.frReportGroups.ShowReport();
end;

procedure TForm3.KindergartenersReportMenuItemClick(Sender: TObject);
begin
  self.frReportKindergarteners.LoadFromFile('report_kindergarteners.lrf');
  self.frReportKindergarteners.ShowReport();
end;

procedure TForm3.RecordsReportMenuItemClick(Sender: TObject);
begin
  self.frReportRecords.LoadFromFile('report_records.lrf');
  self.frReportRecords.ShowReport();
end;

procedure TForm3.RefreshSql();
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

procedure TForm3.FormCreate(Sender: TObject);
begin
  self.RefreshSql();
end;

end.

