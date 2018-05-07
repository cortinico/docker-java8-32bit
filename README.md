# Java8 @32bit Docker container

Dockerfile for creating a 32bit Docker container with Java8 JRE.
The docker container can be downladed form the [Docker Hub](https://hub.docker.com/r/cortinico/java8-32bit/).

You can simply run it with
```bash
docker run -i cortinico/java8-32bit bash
```

## How to run a JAR inside the container
To run a Jar file you have to mount the */data volume*. Let's simply copy the Jar inside a folder (say ```/tmp/jar```):
```bash
mkdir /tmp/jar
cp myapp.jar /tmp/jar
```
And then run the Jar inside the container
```bash
docker run -i -v /tmp/jar:/data cortinico/java8-32bit java -jar myapp.jar
```

## How to run a sample Java File

```sh
vi LongAtomTest.java
javac LongAtomTest.java
```

`docker run -it --rm -v /opt/java:/opt/java -w /opt/java cortinico/java8-32bit java LongAtomTest`

Let's try to run a sample .java file inside the docker container. You can use a sample java file, LongAtomTest.java, pasted below.

```java
// from http://www.cnblogs.com/louiswong/p/5951895.html
public class LongAtomTest implements Runnable {

    private static long field = 0;

    private volatile long value;

    public long getValue() {
        return value;
    }

    public void setValue(long value) {
        this.value = value;
    }

    public LongAtomTest(long value) {
        this.setValue(value);
    }

    @Override
    public void run() {
        int i = 0;
        while (i < 100000) {
            LongAtomTest.field = this.getValue();
            i++;
            long temp = LongAtomTest.field;
            if (temp != 1L && temp != -1L) {
                System.out.println("run fail" + temp);
                System.exit(0);
            }
        }
        System.out.println("run sucess");
    }

    public static void main(String[] args) throws InterruptedException {
        // JVM is 32bit or 64bit
        String arch = System.getProperty("sun.arch.data.model");
        System.out.println(arch+"-bit");
        LongAtomTest t1 = new LongAtomTest(1);
        LongAtomTest t2 = new LongAtomTest(-1);
        Thread T1 = new Thread(t1);
        Thread T2 = new Thread(t2);
        T1.start();
        T2.start();
        T1.join();
        T2.join();
    }

}
```

## How to build the container from the dockerfile
To build the container from this Dockerfile, simply clone the repo and invoke the ```docker build``` command.
```bash
git clone https://github.com/cortinico/docker-java8-32bit.git
cd docker-java8-32bit/
docker build .
```

## Licence
The following software is released under the [MIT Licence](https://github.com/cortinico/docker-java8-32bit/blob/master/LICENSE)
