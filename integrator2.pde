int divisions = 1;
float lowerBound = 0;
float upperBound = 10;
float integral = 0;
float graphBoundary = 0.7;
float graphMargin = 0.2;
float graphUpperBound;
float graphLowerBound;
boolean keyDown = false;
float bellCurve(float x)
{
  return 100*(pow(2.71828,-pow(x,2)/2)/sqrt(2*PI));
}
float f1(float x)
{
  return 10*sin(10*x)+pow(x,2);
}
float f2(float x)
{
  return 10*sin(10*x)+pow(x,2);
}
float f3(float x)
{
  return sin(x);
}
float f(float x)
{
  return 100*sin(10*x)+50*sin(7*x)+pow(x,2)+pow(x,3)-3*x;
}
float f5(float x)
{
  return 10*pow(x,2)+10;
}
void setup()
{
  size(500,500);
  background(0,0,0);
}
void draw()
{
  /*
   fill(255,255,255);
   rect(0,graphBoundary*height,width,height*(1-graphBoundary));
   //while(!keyPressed){}
   //regenerate();
   fill(255,255,255);
   rect(0,graphBoundary*height,width,height*(1-graphBoundary));
   //while(keyPressed){}
   */
   //regenerate();

   
   
}
void keyPressed()
{
  divisions=2*divisions;
  background(0,0,0);
  integral = 0;
  graphLowerBound = f(lowerBound);
  graphUpperBound = f(lowerBound);
  for(int i =0; i<divisions;i++)
  {
    if(f(map(i,0,divisions,lowerBound,upperBound))<graphLowerBound)
    {
      graphLowerBound = f(map(i,0,divisions,lowerBound,upperBound));
    }
    if(f(map(i,0,divisions,lowerBound,upperBound))>graphUpperBound)
    {
      graphUpperBound = f(map(i,0,divisions,lowerBound,upperBound));
    }
  }
  int magnitude;
  if(graphUpperBound!=graphLowerBound)
  {
     magnitude = floor(log(graphUpperBound-graphLowerBound)/log(10))-1;
  }
  else
  {
    magnitude = 0;
  }
  println(magnitude);
  graphUpperBound = ceil(graphUpperBound/pow(10,magnitude))*pow(10,magnitude) + pow(10,magnitude);
  graphLowerBound = floor(graphLowerBound/pow(10,magnitude))*pow(10,magnitude) - pow(10,magnitude);
  
  for(int i =0; i<divisions;i++)
  {
    fill(map(f(map(i,0,divisions,lowerBound,upperBound)),-(abs(graphLowerBound)+abs(graphUpperBound))/2,(abs(graphLowerBound)+abs(graphUpperBound))/2,255,0),map(f(map(i,0,divisions,lowerBound,upperBound)),-(abs(graphLowerBound)+abs(graphUpperBound))/2,(abs(graphLowerBound)+abs(graphUpperBound))/2,0,255),0);
    stroke(map(f(map(i,0,divisions,lowerBound,upperBound)),-(abs(graphLowerBound)+abs(graphUpperBound))/2,(abs(graphLowerBound)+abs(graphUpperBound))/2,255,0),map(f(map(i,0,divisions,lowerBound,upperBound)),-(abs(graphLowerBound)+abs(graphUpperBound))/2,(abs(graphLowerBound)+abs(graphUpperBound))/2,0,255),0);
    strokeWeight(1);
    rect(map(i,0,divisions,0,width),map(0,graphLowerBound,graphUpperBound,height*graphBoundary,0),width/divisions,map(f(map(i,0,divisions,lowerBound,upperBound)),0,graphUpperBound,0,-map(0,graphLowerBound,graphUpperBound,height*graphBoundary,0)));
    integral += (upperBound-lowerBound)*f(map(i,0,divisions,lowerBound,upperBound))/divisions;
  }
  println(integral);
}
