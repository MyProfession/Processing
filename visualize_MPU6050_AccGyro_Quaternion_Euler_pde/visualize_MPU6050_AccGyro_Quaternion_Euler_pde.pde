// PROCESSING .pde
// Visualize filtered accelerometer and gyroscope data using quaternion and eular formulas.
// Version 1.0 (April, 2015).
// Abid Ali,
// IMaR Technology Gateway, Institute of Technology Tralee

//DECLARE ARRAYS
float[] X_FILL_DATA;
float[] Y_FILL_DATA;
float[] Z_FILL_DATA;
float[] ANGLE;
float [] q = new float [4];
float [] hq = null;
float [] Euler = new float [3]; // psi, theta, phi

//DECLARE VARIABLES
int qnum = 0;
//READ FILE USING TABLE
Table table;

//FONT
PFont font;

//WINDOW SIZE
final int VIEW_SIZE_X = 1000, VIEW_SIZE_Y = 1000;


void setup() {
  size(VIEW_SIZE_X, VIEW_SIZE_Y, P3D);
  textureMode(NORMAL);
  fill(255);
  stroke(color(44, 48, 32));

  //READ FILE DATA USING TABLE 
  table = loadTable("vpythonOutput.csv", "header");
  println("Total number of lines are in file: ", table.getRowCount());

  //SET ARRAY LENGHT RANGE
  X_FILL_DATA = new float[table.getRowCount()];
  Y_FILL_DATA = new float[table.getRowCount()];
  Z_FILL_DATA = new float[table.getRowCount()];
  ANGLE = new float[table.getRowCount()];

  //STORE DATA INTO ARRAYS 
  for (int i = 0; i < table.getRowCount (); i++)
  {
    X_FILL_DATA[i] = table.getFloat(i, "FillX");
    Y_FILL_DATA[i] = table.getFloat(i, "FillY");
    Z_FILL_DATA[i] = table.getFloat(i, "FillZ");
    // println("Array "+ i+ " store : X_FILL_DATA[" + X_FILL_DATA[i]+"]" +" Y_FILL_DATA[" + Y_FILL_DATA[i]+"]" + " Z_FILL_DATA[" + Z_FILL_DATA[i]+"]");
  }


  //THIS FONT IS LOCATED IN DATA DIRECTORY 
  font = loadFont("CourierNew36.vlw");
}


//QUATERNION FORMULAT, CONVERT ACCE & GYRO FILTERED DATA INTO QUATERNION 
float [] readQ(int i) {
  ANGLE[i] = atan2(Y_FILL_DATA[i], X_FILL_DATA[i]);
  //println(ANGLE[i]);
  q[0] = cos(ANGLE[i]/2);
  q[1] = X_FILL_DATA[i] * sin(ANGLE[i]/2);
  q[2] = Y_FILL_DATA[i] * sin(ANGLE[i]/2);
  q[3] = Z_FILL_DATA[i] * sin(ANGLE[i]/2);
  //println(q);
  return q;
}

//EULER FORMULAT, CONVERT QUATERNION TO EULER 
void quaternionToEuler(float [] q, float [] euler, float[] ANGLE) {
  euler[0] = atan2(2 * q[1] * q[2] - 2 * q[0] * q[3], 2 * q[0]*q[0] + 2 * q[1] * q[1] - 1); // psi
  euler[1] = -asin(2 * q[1] * q[3] + 2 * q[0] * q[2]); // theta
  //euler[1] = ANGLE[qnum];
  //euler[1] = 0.6;
  euler[2] = atan2(2 * q[2] * q[3] - 2 * q[0] * q[1], 2 * q[0] * q[0] + 2 * q[3] * q[3] - 1); // phi
  println("Theta vaule: ", euler[1]);
}

