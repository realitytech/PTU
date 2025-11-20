unit rtutil;

interface
function uppercase(indata:string):string;   { missing delphi uppercase }
function paramtoint(indata:string):integer; { converts a param str to an int }


implementation

function paramtoint(indata:string):integer;
var
   outputint : integer;
   errcode : integer;
begin
     delete (indata,1,pos(':',indata));
     {$R-}
     val (indata,outputint,errcode);
     if errcode <> 0 then paramtoint:=-1;
     {$R+}
     paramtoint := outputint;
end;


function uppercase(indata:string):string; { missing delphi uppercase }
var
   loop : integer;
   outputstr : string;
begin
   outputstr :='';
   for loop := 1 to length(indata) do
       outputstr := outputstr + upcase(indata[loop]);
   uppercase := outputstr;
end;

end.