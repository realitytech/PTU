 {
IO Port test utility
Written by R.A.Inskip - CC BY-SA

This program simnply alternates two values provided to an IO port
to allow for testing of data bus integrity, latch and select logic
activation or anything else you can think of.

Careful where you point this, it wont make any attempt to stop
you doing something stupid
}

program iotest;
uses crt, rtutil;
var
   test : string;
   portaddr : integer;            { This holds our target port }
   lowerval : integer;            { This holds our first value }
   upperval : integer;            { This holds our upper value }
   delayval : integer;            { and how long we wait... }
   autorun  : boolean;            { Suppress the warning }

procedure noparams;
begin
     writeln ('Use: PTU -p:<port> -d:<delay> -1:<value1> -2:<value2> -A');
end;


procedure doerror (errcode:integer);
begin
     noparams;
     case errcode of
          1 : Writeln ('Port value was invalid. Should be a number with or without $ specifier for hex');
          2 : Writeln ('Port value was invalid. Port must be > 0');
          3 : Writeln ('Port value was invalid. Port must be <$3FF');
          4 : Writeln ('Delay value was invalid and should be a whole number');
          5 : Writeln ('Delay value must be greater than 0');
          6 : Writeln ('Delay value should be less than 2000');
          7 : Writeln ('Output value was invalid. Should be a whole number from 0 to 255');
          8 : Writeln ('Output value was invalid. Should be less than 255');
          9 : Writeln ('You were not sure, sorry! Try using -A!');
          end;
     halt(errcode);
end;

procedure dotest;
begin
     write ('Port : ');
     write (portaddr);
     write (' will be written to with ');
     write (lowerval);
     write (' and ');
     write (upperval);
     write (' at intervals of ');
     write (delayval);
     writeln (' mS');
     writeln ('Test starting, press any key to abort...');
     while not keypressed do
           begin
           port[portaddr]:=lowerval;
           write ('-');
           delay (delayval);
           port[portaddr]:=upperval;
           write ('+');
           delay (delayval);
           end;
end;

procedure getparams;
var
   working : string;
   errorcode : integer;
   loop : integer;
begin
      autorun := false;
     for loop :=1 to paramcount do begin  { iterate through our command paramters }
         working := uppercase (paramstr(loop));
         if pos ('-P:',working) <>0 then begin { we have a port directive }
            portaddr := paramtoint(paramstr(loop));
            if ((portaddr = -1) or (portaddr =0)) then doerror (1)
            else if portaddr <=0 then doerror(2)
            else if portaddr >$3ff then doerror(3);
            end;
         if pos ('-D:',working) <>0 then begin { we have a delay directive }
            delayval := paramtoint(paramstr(loop));
            if ((delayval = -1) or (delayval =0)) then doerror (4)
            else if delayval <=0 then doerror(5)
            else if delayval >2000 then doerror(6);
            end;
         if pos ('-1:',working) <>0 then begin { we have our first pattern }
            lowerval := paramtoint(paramstr(loop));
            if (lowerval = -1) then doerror (7)
            else if lowerval >$ff then doerror(8);
            end;
         if pos ('-2:',working) <>0 then begin { we have our second pattern }
            upperval := paramtoint(paramstr(loop));
            if (upperval = -1) then doerror (7)
            else if upperval >$ff then doerror(8);
            end;
         if pos ('-A',working) <>0 then begin { autorun was set }
            autorun := true;
            end;
         {we could test for more here}
         end; {case}
         {make sure we actually have values that make sense}
         if portaddr =0 then doerror(1);
         if delayval =0 then doerror(4);
         {to be fair values of 0 for upper and lower are valid for testing addr latches}

end;

procedure reallysure;
var
   instr : string;
begin
     writeln ('!!! WARNING !!!');
     writeln ('This program has the potential to REALLY break your machine!');
     writeln ('It is possible to cause data loss and even physical damage using');
     writeln ('this program.');
     writeln ('');
     writeln ('Are you REALLY, REALLY sure you want to do this? Type YES to continue');
     readln (instr);
     if instr <>'YES' then doerror(9);
end;



begin
     writeln ('Port Test Utility for DOS');
     writeln ('Version 0.1 R.Inskip');
     writeln ('Github: /realitytech/ptu');
     writeln ('');
     str (paramcount,test);
     if paramcount = 0 then begin
         noparams;
         halt(99);
         end
     else begin
          getparams;
          if not autorun then reallysure;
          dotest;
          end;
end.