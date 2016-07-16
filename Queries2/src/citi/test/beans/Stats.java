package citi.test.beans;

public class Stats {
	
	//LogDate	QryRespTime	SumCPU	SumIO	CPUSKW	IOSKW	PJI	UII	ImpactCPU	rowct
	
	private String logDate;
	
	private String queryResponseTime;
	
	private String sumCPU;
	
	private String sumIO;
	
	private String cpuSkw;
	
	private String ioSkw;
	
	private String pji;
	
	private String uii;
	
//	private String impactCpu;
	
	private String rowCount;

	public String getQueryResponseTime() {
		return queryResponseTime;
	}

	public void setQueryResponseTime(String queryResponseTime) {
		this.queryResponseTime = queryResponseTime;
	}

	public String getSumCPU() {
		return sumCPU;
	}

	public void setSumCPU(String sumCPU) {
		this.sumCPU = sumCPU;
	}

	public String getSumIO() {
		return sumIO;
	}

	public void setSumIO(String sumIO) {
		this.sumIO = sumIO;
	}

	public String getCpuSkw() {
		return cpuSkw;
	}

	public void setCpuSkw(String cpuSkw) {
		this.cpuSkw = cpuSkw;
	}

	public String getIoSkw() {
		return ioSkw;
	}

	public void setIoSkw(String ioSkw) {
		this.ioSkw = ioSkw;
	}

	public String getPji() {
		return pji;
	}

	public void setPji(String pji) {
		this.pji = pji;
	}

	public String getUii() {
		return uii;
	}

	public void setUii(String uii) {
		this.uii = uii;
	}

//	public String getImpactCpu() {
//		return impactCpu;
//	}
//
//	public void setImpactCpu(String impactCpu) {
//		this.impactCpu = impactCpu;
//	}

	public String getRowCount() {
		return rowCount;
	}

	public void setRowCount(String rowCount) {
		this.rowCount = rowCount;
	}

	public String getLogDate() {
		return logDate;
	}

	public void setLogDate(String logDate) {
		this.logDate = logDate;
	}

}
