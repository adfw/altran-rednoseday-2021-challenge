-- Altran Red Nose Day 2021 Challenge
-- A SPARK2014 solution by Anthony Williams
-- 
-- Reads puzzle input from stdin.
-- e.g. $ ./code < puzzle.txt


with Ada.Text_IO;

procedure Code is

   type Move_T is (U, D, L, R, Invalid);

   type Char_To_Move_T is Array (Character) of Move_T;

   Char_To_Move : constant Char_To_Move_T := Char_To_Move_T'
      ('U' => U,
       'D' => D,
       'L' => L,
       'R' => R,
       others => Invalid);

   type Code_T is new Long_Long_Integer range 0 .. Long_Long_Integer'Last;

   subtype Grid_Row is Code_T range 1 .. 3;
   subtype Grid_Col is Code_T range 0 .. 2;

   type Keypad_T is record
      Row : Grid_Row;
      Col : Grid_Col;
   end record;

   Move : Move_T;

   Move_Char : Character;

   Position_P1 : Keypad_T := (2, 1);
   Position_P2 : Keypad_T := (2, 1);

   Result_Part1 : Code_T := 0;
   Result_Part2 : Code_T := 0;

   procedure Add_Digit
      (Keypad : in     Keypad_T;
       Result : in out Code_T)
   is
      -- Convert keypad position to a value.
      This_Number : Code_T := Keypad.Row + (Keypad.Col * 3);
   begin
      if Code_T'Last / 10 - This_Number > Result then
         Result := Result * 10;
         Result := Result + This_Number;
      else
         Ada.Text_IO.Put_Line ("Overflow!");
      end if;
   end Add_Digit;

begin

   loop

      Ada.Text_IO.Get (Move_Char);

      Move := Char_To_Move (Move_Char);

      case Move is 
         when L => 
            if Position_P1.Row > Grid_Row'First then
               Position_P1.Row := Position_P1.Row - 1;
            end if;
            if Position_P2.Row = Grid_Row'First then
               Position_P2.Row := Position_P2.Row + 1;
            else
               Position_P2.Row := Position_P2.Row - 1;
            end if;
         when R => 
            if Position_P1.Row < Grid_Row'Last then
               Position_P1.Row := Position_P1.Row + 1;
            end if;
            if Position_P2.Row = Grid_Row'Last then
               Position_P2.Row := Position_P2.Row - 1;
            else
               Position_P2.Row := Position_P2.Row + 1;
            end if;
         when U => 
            if Position_P1.Col > Grid_Col'First then
               Position_P1.Col := Position_P1.Col - 1;
            end if;
            if Position_P2.Col = Grid_Col'First then
               Position_P2.Col := Position_P2.Col + 1;
            else
               Position_P2.Col := Position_P2.Col - 1;
            end if;
         when D => 
            if Position_P1.Col < Grid_Col'Last then
               Position_P1.Col := Position_P1.Col + 1;
            end if;
            if Position_P2.Col = Grid_Col'Last then
               Position_P2.Col := Position_P2.Col - 1;
            else
               Position_P2.Col := Position_P2.Col + 1;
            end if;
         when Invalid => 
            Ada.Text_IO.Put_Line ("Invalid input!");
      end case;

      if Ada.Text_IO.End_Of_Line then
         Add_Digit (Position_P1, Result_Part1);
         Add_Digit (Position_P2, Result_Part2);
      end if;

      exit when Ada.Text_IO.End_Of_File;

   end loop;
   Ada.Text_IO.Put_Line ("Part 1:" & Result_Part1'Img);
   Ada.Text_IO.Put_Line ("Part 2:" & Result_Part2'Img);

end Code;
