public with sharing class SPE_Utility 
{
    public static Map<Integer, String> monthsMap = new Map<Integer, String>
    {
        1 => 'January',
        2 => 'February',
        3 => 'March',
        4 => 'April',
        5 => 'May',
        6 => 'June',
        7 => 'July',
        8 => 'August',
        9 => 'September',
        10 => 'October',
        11 => 'November',
        12 => 'December'
    };
    
    public static Map<Integer,String> IndexMap= new Map<Integer,String>
    {    1 => 'A', 2 => 'B', 3 => 'C', 4 => 'D', 5 => 'E',
         6 => 'F', 7 => 'G',8 => 'H', 9 => 'I', 10 => 'J',
         11 => 'K', 12 => 'L', 13 => 'M', 14 => 'N',15 => 'O',
         16 => 'P', 17 => 'Q', 18 => 'R', 19 => 'S', 20 => 'T',
         21 => 'U',22 => 'V', 23 => 'W', 24 => 'X', 25 => 'Y', 26 => 'Z'
    };
    
    public static Set<String> indexList = new Set<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
                                                            'U', 'V', 'W', 'X', 'Y', 'Z'};
    
    public static Set<String> operatorList = new Set<String> {'+', '-', '*', '/'};

}