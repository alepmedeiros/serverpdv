unit server.connections.impl.firedac;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  server.connections.interfaces;

type
  TDataBaseConnection = class(TInterfacedObject, IDataBaseConnection)
  private
    FConn: TFDConnection;
    FQuery: TFDQuery;

    procedure PreencherQuery(Value: String);
    procedure PreencherParams(Value: Array of Variant);

    constructor Create;
    destructor Destroy; override;
  public
    class function New: IDataBaseConnection;

    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
    procedure Query(const Statement: String; const Prams: Array of Variant; var DataSource: TDataSource);
  end;

implementation

{ TDataBaseConnection }

procedure TDataBaseConnection.Commit;
begin
  FConn.Commit;
end;

constructor TDataBaseConnection.Create;
begin
  FConn := TFDConnection.Create(nil);

  var lDataBase := GetEnvironmentVariable('DATABASE');
  var lServer := GetEnvironmentVariable('SERVER');
  var lUserName := GetEnvironmentVariable('USERNAME');
  var lPassword := GetEnvironmentVariable('PASSWORD');
  var lPort := GetEnvironmentVariable('PORT');

  FConn.Params.DriverID := 'PG';
  FConn.Params.Database := lDataBase;
  FConn.Params.Add('Server='+lServer);
  FConn.Params.UserName := lUserName;
  FConn.Params.Password := lPassword;
  FConn.Params.Add('PORT='+lPort);
  FConn.Params.Add('CharacterSet=utf8');
  FConn.Connected;

  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConn;
end;

destructor TDataBaseConnection.Destroy;
begin
  FConn.Free;
  inherited;
end;

class function TDataBaseConnection.New: IDataBaseConnection;
begin
  REsult := Self.Create;
end;

procedure TDataBaseConnection.PreencherParams(Value: array of Variant);
begin
  for var I := Low(Value) to High(Value) do
  begin
    FQuery.Params.Add;
    FQuery.Params[I].Value := Value[I];
  end;
end;

procedure TDataBaseConnection.PreencherQuery(Value: String);
begin
 if not FConn.Connected then
    FConn.Connected := True;

  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(Value);
end;

procedure TDataBaseConnection.Query(const Statement: String;
  const Prams: array of Variant; var DataSource: TDataSource);
begin
  PreencherQuery(Statement);
  PreencherParams(Prams);

  if (not (Pos('UPDATE', UpperCase(Statement)) > 0)) or
    (not (Pos('INSERT', UpperCase(Statement)) > 0)) then
  begin
    FQuery.Open;
    DataSource.DataSet := FQuery;
    Exit;
  end;
  FQuery.ExecSQL;
end;

procedure TDataBaseConnection.Rollback;
begin
  FConn.Rollback;
end;

procedure TDataBaseConnection.StartTransaction;
begin
  FConn.StartTransaction;
end;

end.
