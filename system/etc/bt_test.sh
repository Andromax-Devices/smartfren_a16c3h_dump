#!/system/bin/sh

LOG_TAG="bt"
LOG_NAME="${0}:"

#btconfig /dev/smd3 rawcmd 0x08 0x001e 0x00 0x25 0x00

# rate:edr/le
rate=`getprop persist.bt.rate`

#mode:manual/auto
mode=`getprop persist.bt.mode`

#direction:rx/tx
dir=`getprop persist.bt.dir`

#get channel,data length and packet
#channel:0x00-0x27 (Frequency range: 2402 MHz-2480 MHz)
#data length:0x00-0x25
#packet:0x00-0x07
#
# packet meaning:
# 0x00 Pseudo-random bit sequence 9
# 0x01 Pattern of alternating bits ¡®11110000¡¯
# 0x02 Pattern of alternating bits ¡®10101010¡¯
# 0x03 Pseudo-random bit sequence 15
# 0x04 Pattern of All ¡®1¡¯ bits
# 0x05 Pattern of All ¡®0¡¯ bits
# 0x06 Pattern of alternating bits '00001111'
# 0x07 Pattern of alternating bits '0101'

channel=`getprop persist.bt.chan`
data_len=`getprop persist.bt.data_len`
packet=`getprop persist.bt.pack`

#test state:le_off/edr_off
state=`getprop persist.bt.state`

logi ()
{
  /system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

# packet logging
packet_logging ()
{
	case $packet in
		0x0)
			logi "packet $packet set:Pseudo-random bit sequence 9";;
		1)
			logi "packet $packet set:Pattern of alternating bits 11110000";;
		2)
			logi "packet $packet set:Pattern of alternating bits 10101010";;
		3)
			logi "packet $packet set:Pseudo-random bit sequence 15";;
		4)
			logi "packet $packet set:Pattern of All 1 bits";;
		5)
			logi "packet $packet set:Pattern of All 0 bits";;
		6)
			logi "packet $packet set:Pattern of alternating bits 00001111";;
		7)
			logi "packet $packet set:Pattern of alternating bits 0101";;
		*)
		;;
	esac
}

failed ()
{
    loge "$1: exit code $2"
    exit $2
}

le_rx_end ()
{
    logi "le rx end"
    # end
    #btconfig /dev/smd3 rawcmd 0x08 0x001F
    #PKTCNT=`btconfig /dev/smd3 lete`
    btconfig /dev/smd3 lete > /sdcard/.btpkcnt
#    logi "rx:$PKTCNT"
#    PKTCNT2=`cat $PKTCNT |grep "Number of packets ="`
#    cat $PKTCNT |grep -o "Number of packets =" > /sdcard/.btpkcnt
    cat /sdcard/.btpkcnt |grep -o "Number of packets = [0-9]*" > /sdcard/.btpkcnt2
    logi "get `cat /sdcard/.btpkcnt2`"
    cat /sdcard/.btpkcnt2 |grep -o "[0-9]*[0-9]" > /sdcard/.btpkcnt3
    PKTCNT=`cat /sdcard/.btpkcnt3`
    logi "revieve:$PKTCNT"
    setprop persist.bt.getpkt $PKTCNT
#    setprop persist.bt.test 0
#    exit 0
}

test_state_switch ()
{
    case $state in
	"get_pkt")
	    if [ $rate = "le" -a $dir = "rx" ];then
		le_rx_end
	    fi
	    if [ $rate = "edr" ];then
		setprop persist.bt.getpkt 0
	    fi
	    setprop persist.bt.test 0
	    exit 0
	    ;;
	"le_off")
	    case $dir in
		*)
		    setprop persist.bt.test 0
		    exit 0
		    ;;
	    esac
	    ;;
	"edr_off")
	    logi "edr end test"
	    btconfig /dev/smd3 reset
	    setprop persist.bt.test 0
	    exit 0
	    ;;
	*)
	    logi "start testing"
	    ;;
    esac
}

logi "bt test version:150701-1"

test_state_switch

case $rate in
    "edr")
	case $mode in
	    "manual")
		logi "$rate $mode unsupported now"
	    ;;
	    "auto")
		logi "$rate $mode"
		sh /system/etc/bt_dut_on.sh
		;;
	    *)
		logi "mode $mode not valid"
	    ;;
	esac
    ;;
    *)
esac

case $rate in
    "le")
	case $dir in
		"tx")
			logi "$rate $mode $dir,set channel:$channel,data length:$data_len,packet:$packet"
			packet_logging
			btconfig /dev/smd3 reset
			btconfig /dev/smd3 rawcmd 0x08 0x001E $channel $data_len $packet
	    ;;
	    "rx")
			logi "$rate $mode $dir,set channel:$channel"
			btconfig /dev/smd3 reset
			btconfig /dev/smd3 rawcmd 0x08 0x001D $channel
	    ;;
	    *)
		logi "dir $dir not valid"
	    ;;
	esac
	;;
	*)
esac

setprop persist.bt.test 0
exit 0
