package dto;

import java.sql.Timestamp;

public class Clients {
	private int no;
	private int cnt;
	private Timestamp current_times;
	private String tx;
	private String rx;
	private double rxTraffic;
	private double txTraffic;

	public double getRxTraffic() {
		return rxTraffic;
	}

	public void setRxTraffic(double rxTraffic) {
		this.rxTraffic = rxTraffic;
	}

	public double getTxTraffic() {
		return txTraffic;
	}

	public void setTxTraffic(double txTraffic) {
		this.txTraffic = txTraffic;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public Timestamp getCurrent_times() {
		return current_times;
	}

	public void setCurrent_times(Timestamp current_times) {
		this.current_times = current_times;
	}

	public String getTx() {
		return tx;
	}

	public void setTx(String tx) {
		this.tx = tx;
	}

	public String getRx() {
		return rx;
	}

	public void setRx(String rx) {
		this.rx = rx;
	}

}
