unit service.repository.interfaces;

interface

uses
  System.Generics.Collections;

type
  IRepository<T: class> = interface
    ['{0F9A74B5-F78C-4F8E-8B52-D54721CE3449}']
    function Listar: IRepository<T>;
    function ListarPorId(Value: String): IRepository<T>;
    function Excluir(Value: String): IRepository<T>;
    function Atualizar: IRepository<T>;
    function Inserir: IRepository<T>;
    function This: T;
    function These: TObjectList<T>;
  end;

implementation

end.
