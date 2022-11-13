class Dinfo {
    int i, j;
    float d;
    
    Dinfo() {
        i = 0;
        j = 0;
        d = 0;
    }
    
    Dinfo(int i_, int j_, float d_) {
        i = i_;
        j = j_;
        d = d_;
    }
}

public class DinfoComparator implements Comparator<Dinfo> {
    public int compare(Dinfo di1, Dinfo di2) {
        if (di1.d > di2.d) {
            return1;
        } else if (di1.d < di2.d) {
            return- 1;
        } return 0;
    }
}