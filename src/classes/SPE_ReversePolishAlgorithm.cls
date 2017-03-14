public class SPE_ReversePolishAlgorithm 
{
    public static Decimal reversePolishCalculation (Object[] rpnExprStack) 
    {
        System.debug('-------------->'+rpnExprStack);
        
        Decimal res = 0;
        
        List<Decimal> stack = new List<Decimal>();
        
        if (rpnExprStack.size() == 1)
        {
            Object expr0 = rpnExprStack[0];
            if (expr0 instanceOf Decimal)
            {
                res = (Decimal) expr0;
                
                return res;
            }
        }
        
        for (Object obj : rpnExprStack)
        {
            Object expr0 = obj;
            if (expr0 instanceOf Decimal)
            {
                stack.add((Decimal) expr0);
            }
            else
            {
                String operator = (String) expr0;
                system.debug('operator ::'+operator);
                system.debug('stack ::'+stack);
                Decimal b = stack[stack.size()-1] == null ? null : stack[stack.size()-1];
                Decimal a = stack[stack.size()-2] == null ? null : stack[stack.size()-2];
                
                stack.remove(stack.size()-1);
                stack.remove(stack.size()-1);
                
                
                
                if (operator == '+')
                {
                    res = (a== null || b == null) ? null :  a + b;
                }    
                if (operator == '-')
                {
                    res = (a== null || b == null) ? null : a - b;
                }
                if (operator == '*')
                { 
                    res = (a== null || b == null) ? null : a * b ;
                }
                if (operator == '/')
                {
                    if (b == null || a == null || b == 0)
                    {
                        res = null;
                    }
                    else
                    {
                        res = a / b;
                    }
                }
                
                stack.add(res);
            }
            
        }
        
        return res;
    }
    
    public static Decimal reversePolishCalculationDate (Object[] rpnExprStack) 
    {
        System.debug('-------------->'+rpnExprStack);
        
        Decimal res = 0;
        
        List<Date> stack = new List<Date>();
        
        if (rpnExprStack.size() == 1)
        {
            Object expr0 = rpnExprStack[0];
            if (expr0 instanceOf Date)
            {
                return res;
            }
        }
        
        for (Object obj : rpnExprStack)
        {
            Object expr0 = obj;
            if (expr0 instanceOf Date)
            {
                stack.add((Date) expr0);
            }
            else
            {
                String operator = (String) expr0;
                
                Date b = stack[stack.size()-1] == null ? null : stack[stack.size()-1];
                Date a = stack[stack.size()-2] == null ? null : stack[stack.size()-2];
                
                stack.remove(stack.size()-1);
                stack.remove(stack.size()-1);
                
                if (operator == '-')
                {
                    res = (a== null || b == null ) ? null : (Decimal)a.daysBetween(b);
                }
                
                //stack.add(res);
            }
            
        }
        
        return res;
    }
    
    
    public static Boolean conditionComparision(Decimal criteria1, Decimal criteria2, String condition)
    {
    
        Boolean result = false;
        if (condition == '==')
        {
            if (criteria1 == criteria2)
            {
                result = true;
            }
        }
        else if (condition == '>')
        {
            if (criteria1 > criteria2)
            {
                result = true;
            }
        }
        else if (condition == '>=')
        {
            if (criteria1 >= criteria2)
            {
                result = true;
            }
        }
        else if (condition == '<')
        {
            if (criteria1 < criteria2)
            {
                result = true;
            }
        }
        else if (condition == '<=')
        {
            if (criteria1 <= criteria2)
            {
                result = true;
            }
        }
        else if (condition == '!=')
        {
            if (criteria1 != criteria2)
            {
                result = true;
            }
        }
        else if (condition == 'Null')
        {
            if (criteria1 == null || criteria1 == 0 || criteria1 == 0.0 )
            {
                result = true;
            }
        }
        else if (condition == 'Not Null')
        {
            if (criteria1 != null)
            {
                result = true;
            }
        }
        
        return result;
    }
}