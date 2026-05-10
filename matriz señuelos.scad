$fn = 80;

// ------------------
// BASE
// ------------------
base_x = 240;
base_y = 180;
thickness = 12;

// ------------------
// CUERPO (FORMA PEZ)
// ------------------
module cuerpo(largo, ancho) {
    hull() {
        translate([0,0,0]) sphere(d=ancho);
        translate([largo*0.4,0,0]) sphere(d=ancho*0.9);
        translate([largo*0.8,0,0]) sphere(d=ancho*0.6);
    }
}

// ------------------
// COLAS
// ------------------

// Paddle
module cola_paddle(largo, ancho) {
    translate([largo*0.85,0,0])
        cylinder(h=15, d1=ancho*0.5, d2=ancho*0.2);

    translate([largo,0,0])
        scale([1.2,1,0.4])
            sphere(d=ancho*1.8);
}

// Curly
module cola_curly(largo, ancho) {
    for(i=[0:12])
        translate([largo - i*3, sin(i*25)*6, 0])
            sphere(d=ancho*0.25);
}

// Fork
module cola_fork(largo, ancho) {
    translate([largo*0.9,0,0]) {
        translate([0,5,0]) cylinder(h=20, d=ancho*0.25);
        translate([0,-5,0]) cylinder(h=20, d=ancho*0.25);
    }
}

// Jerk
module cola_jerk(largo, ancho) {
    translate([largo*0.85,0,0])
        cylinder(h=20, d1=ancho*0.5, d2=ancho*0.2);
}

// ------------------
// VINILO COMPLETO
// ------------------
module vinilo(largo, ancho, tipo=0) {
    union() {
        cuerpo(largo, ancho);

        if (tipo==0) cola_paddle(largo, ancho);
        if (tipo==1) cola_curly(largo, ancho);
        if (tipo==2) cola_fork(largo, ancho);
        if (tipo==3) cola_jerk(largo, ancho);
    }
}

// ------------------
// MOLDE (OPEN POUR)
// ------------------
difference() {
    cube([base_x, base_y, thickness]);

    // IMPORTANTE: rotar correctamente
    translate([30,40,2])
        rotate([0,90,0])
            vinilo(100,12,0);

    translate([130,40,2])
        rotate([0,90,0])
            vinilo(140,13,1);

    translate([40,120,2])
        rotate([0,90,0])
            vinilo(180,14,2);

    translate([140,120,2])
        rotate([0,90,0])
            vinilo(200,15,3);
}