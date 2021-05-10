Function a = new Function();
Function b = new Function();
Exponential c = new Exponential(2,(float)Math.E);
Button chooseNomial;
Button chooseSinusoidal;
Button chooseExponential;
Button[] buttons = new Button[3];
String stage = "Passive";
void setup()
{
  background(0);
  size(500,500);
  a.termsNomial.add(new Nomial(1,2));
  a.termsNomial.add(new Nomial(2,0.5));
  a.termsNomial.add(new Nomial(10,0));
  a.termsNomial.add(new Nomial(PI,1));
  b.termsNomial.add(new Nomial(1,3));
  b.termsNomial.add(new Nomial(4,-1));
  b.termsSinusoidal.add(new Sinusoidal(4,0));
  println(a.value(4));
  println(a.name());
  println(b.value(4));
  println(b.name());
  println(c.value(PI));
  println(c.name());
  chooseNomial = new Button(width/6,200,150,50,150,0,0, "Nomial");
  chooseSinusoidal = new Button(width/2,200,150,50,0,150,0, "Sinusoidal");
  chooseExponential = new Button(5*width/6,200,150,50,0,0,150, "Exponential");
  buttons[0] = chooseNomial;
  PFont mono = createFont("Lucida Console",32);
  textFont(mono);
 
}
void draw()
{
  background(0);
  fill(255);
  textSize(32);
  textAlign(CENTER,TOP);
  text("Function Generator",width/2,50);
  textAlign(LEFT,TOP);
  textSize(12);
  text("f(x) = " + a.name(),10,100, width-10,150);
  chooseNomial.conjure();
  chooseSinusoidal.conjure();
  chooseExponential.conjure();
  checkStages();
  if(stage == "Passive"){}
  else if (stage == "Nomial")
  {
    textAlign(CENTER,TOP);
    fill(255,255,255);
    text("Coefficient",width/6,250);
    text("Exponent",width/6,280);
  }
  else if (stage == "Sinusoidal")
  {
    textAlign(CENTER,TOP);
    fill(255,255,255);
    text("Coefficient",width/2,250);
    text("Type",width/2,280);
  }
  else if (stage == "Exponential")
  {
    textAlign(CENTER,TOP);
    fill(255,255,255);
    text("Coefficient",5*width/6,250);
    text("Base",5*width/6,280);
  }
  println(stage);
}
void checkStages()
{
  for(int i = 0; i < buttons.length; i++)
  {
    buttons[i].checkActivation();
  }
  for(int i = 0; i < buttons.length; i++)
  {
    if(buttons[i].activated == 2)
    {
      stage = buttons[i].name;
      for(int j = 0; j < buttons.length; j++)
      {
        if(buttons[i] != buttons[j])
        {
          buttons[j].activated = 0;
        }
      }
    }
  }
}
class Button
{
  float xCenter;
  float yCenter;
  float xLength;
  float yLength;
  color cLight;
  color cDark;
  String name;
  int activated = 0;
  Button(float xCenterTemporary, float yCenterTemporary, float xLengthTemporary, float yLengthTemporary, int r, int g, int b, String nameTemporary)
  {
    xCenter = xCenterTemporary;
    yCenter = yCenterTemporary;
    xLength = xLengthTemporary;
    yLength = yLengthTemporary;
    cLight = color(r,g,b);
    cDark = color(r/10,g/10,b/10);
    name = nameTemporary;
  }
  void conjure()
  {
    rectMode(CENTER);
    if(beingTouched())
    {
      fill(cLight);
    }
    else
    {
      fill(cDark);
    }
    stroke(255);
    strokeWeight(5);
    rect(xCenter,yCenter,xLength,yLength);
    rectMode(CORNER);
    textAlign(CENTER,CENTER);
    fill(255,255,255);
    text(name,xCenter,yCenter);
  }
  void checkActivation()
  {
    if(beingClicked())
    {
      if(activated == 0)
      { 
        activated = 1;
      }
      if(activated == 2)
      {
        activated = 3;
      }
    }
    if(!beingClicked())
    {
      if(activated == 1)
      {
        activated = 2;  
      }
      if(activated == 3)
      {
        activated = 0;
      }
    }
  }
  boolean beingTouched()
  {
    return (mouseX > xCenter - xLength/2 && mouseX < xCenter + xLength/2) && (mouseY > yCenter - yLength/2 && mouseY < yCenter + yLength/2);
  }
  boolean beingClicked()
  {
    return (mousePressed && beingTouched());

  }
}
class Nomial
{
  float coefficient;
  float exponent;
  Function derivative = new Function();
  Function integral = new Function();
  Nomial(float coefficientCurrent,float exponentCurrent)
  {
    coefficient = coefficientCurrent;
    exponent = exponentCurrent;
  }
  float value(float x)
  {
    return coefficient*pow(x,exponent);
  }
  String name()
  {
    String y = "";
    if(coefficient == 0)
    {
      y = "invalid";
    }
    else if(coefficient == 1)
    {
      if(exponent == 0)
      {
        y += "1";
      }      
    }
    else
    {
      if(coefficient == round(coefficient))
      {
        y += round(coefficient);
      }
      else
      {
        y += coefficient;
      }
    }
    if(exponent != 0)
    {
      if(exponent == 1)
      {
        y += "x";
      }
      else
      {
        if(exponent == round(exponent))
        {
          y += "x^" + round(exponent);
        }
        else
        {
          y += "x^" + exponent;
        }
      }
    }
    return y;
  }
  Nomial derivative()
  {
    return new Nomial(coefficient*exponent,exponent-1);
  }
  Nomial integral()
  {
    return new Nomial(coefficient/(exponent+1),exponent+1);
  }
}

class Sinusoidal
{
  float coefficient;
  int type;
  Sinusoidal(float coefficientCurrent,int typeCurrent)
  {
    coefficient = coefficientCurrent;
    type = typeCurrent;
  }
  float value(float x)
  {
    if(type==0)
    {
      return coefficient*sin(x);
    }
    if(type==1)
    {
      return coefficient*cos(x);
    }
    if(type==2)
    {
      return coefficient*tan(x);
    }
    else
    {
      return 0;
    }
  }
  String name()
  {
    String y = "";
    if(coefficient != 0 && (type == 0 || type == 1 || type == 2))
    {
      if(coefficient != 1)
      {
        if(coefficient == round(coefficient) && coefficient !=1)
        {
          y += round(coefficient);
        }
        else
        {
          y += coefficient;
        }
      }
      if(type == 0)
      {
        y += "sin(x)";
      }
      if(type == 1)
      {
        y += "cos(x)";
      }
      if(type == 2)
      {
        y += "tan(x)";
      }
    }
    else
    {
      y = "invalid";
    }
    return y;
  }
}
class Exponential
{
  float coefficient;
  float base;
  Exponential(float coefficientCurrent,float baseCurrent)
  {
    coefficient = coefficientCurrent;
    base = baseCurrent;
  }
  float value(float x)
  {
    return coefficient*pow(base,x);
  }
  String name()
  {
    String y = "";
    if(coefficient == 0 || base == 1 || base <= 0)
    {
      y = "invalid";
    }
    else
    {
      if(coefficient != 1)
      {
        if(coefficient == round(coefficient))
        {
          y += round(coefficient) + "*";
        }
        else
        {
          y += coefficient + "*";
        }
      }
      y += base + "^x";
    }
    return y;
  }
}
class Function
{
  ArrayList<Nomial> termsNomial = new ArrayList<Nomial>();
  ArrayList<Sinusoidal> termsSinusoidal = new ArrayList<Sinusoidal>();
  Function()
  {
  }
  float value(float x)
  {
    float y = 0;
    for(int i = 0; i < termsNomial.size(); i++)
    {
      y += termsNomial.get(i).value(x);
    }
    for(int i = 0; i < termsSinusoidal.size(); i++)
    {
      y += termsSinusoidal.get(i).value(x);
    }
    return y;
  }
  String name()
  {
    String y = "";
    y += termsNomial.get(0).name();
    for(int i = 1; i < termsNomial.size(); i++)
    {
      y += " + ";
      y += termsNomial.get(i).name();
    }
    for(int i = 0; i < termsSinusoidal.size(); i++)
    {
      y += " + ";
      y += termsSinusoidal.get(i).name();
    }
    return y;
  }
}
