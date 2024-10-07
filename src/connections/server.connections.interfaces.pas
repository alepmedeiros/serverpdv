unit server.connections.interfaces;

interface

uses
  Data.DB;

type
  IDataBaseConnection = interface
    ['{13084D04-093A-4243-B84E-CE3E2D919A3A}']
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
    procedure Query(const Statement: String; const Prams: Array of Variant; var DataSource: TDataSource);
  end;

implementation

end.
