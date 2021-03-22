union() {
   $fn = 100;
   difference() {
      $fn = 100;
      cylinder(d=20,h=10);
      cylinder(d=15,h=5);
   }
   translate([0,0,10]) cylinder(d=10,h=5);
   translate([0,0,15]) cylinder(d=20,h=5);
}
