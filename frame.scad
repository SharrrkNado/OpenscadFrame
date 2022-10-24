width = 200;
length = 500;
height = 40;

//materialstärke
th = 6;

// Anzahl Querverbindungen
anz = 6;

// Abstand Überkreuzung
margin = 30;

// Toleranzkorrektur
tol = 0.25; 

// Radius für Rundung
rad = 5;


// Schnitttiefe. zB.: height/2
cutDepth = height/3;

// Vorschau
!preview();

// Schnittansicht
renderview();


// Testück
test();




// ===========================================================
$fn = 64;
red = [1,0,0];
green = [0,1,0];
blue = [0,0,1];

module renderview(){
    lang();
    t(height*2+th)r(0,0,90)sub();
}

module preview(){
   t(0,0,-height-th)color(red)t(th+margin)r(0,-90)extr()lang();
   color(red)t(width-margin)r(0,-90)extr()lang();
   color(green)t(0,0,height-cutDepth*2)loop()r(90)extr()sub();    
}

module test(){
    difference(){
        square([height,height]);
        #t(height/2-th/2+tol/2)square([th-tol, cutDepth]);
        
    }
}

module lang(){
    difference(){
        roundedSquare(height, length, rad);
        loop()t(height-cutDepth,-th+tol/2)square([cutDepth, th-tol]);
    }
}

module sub(){
    difference(){
        square([width, height]);
        t(margin+tol/2)square([th-tol, cutDepth]);
        t(width-margin-th+tol/2)square([th-tol, cutDepth]);
    }   
}


module loop(){
    for(n=[0:1:anz-1]){
        t(0,margin+th+n*(length-th-margin*2)/(anz-1),0)children();
    }
}

module extr(){
    linear_extrude(th)children();
}

module t(x=0,y=0,z=0){
    translate([x,y,z])children();
}

module r(x=0,y=0,z=0){
    rotate([x,y,z])children();
}


module roundedSquare(w,l,rad){
    hull(){
        t(rad/2,rad/2)circle(d=rad);
        t(w-rad/2,rad/2)circle(d=rad);
        t(rad/2,l-rad/2)circle(d=rad);
        t(w-rad/2,l-rad/2)circle(d=rad);
    }
}
