Function a = new Function();
Function b = new Function();
Exponential c = new Exponential(2,(float)Math.E);
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
}
void draw()
{
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
          y += round(coefficient);
        }
        else
        {
          y += coefficient;
        }
      }
      y += "*" + base + "^x";
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
