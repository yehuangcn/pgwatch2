/* Pre-requisites: PL/Pythonu and "psutil" Python package (e.g. pip install psutil) */

CREATE OR REPLACE FUNCTION public.get_psutil_disk_io_total(
	OUT read_count float8, OUT write_count float8, OUT read_bytes float8, OUT write_bytes float8
)
 LANGUAGE plpythonu
 SECURITY DEFINER
AS $FUNCTION$
from psutil import disk_io_counters
dc = disk_io_counters(perdisk=False)
return dc.read_count, dc.write_count, dc.read_bytes, dc.write_bytes
$FUNCTION$;

REVOKE EXECUTE ON FUNCTION public.get_psutil_disk_io_total() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.get_psutil_disk_io_total() TO pgwatch2;
COMMENT ON FUNCTION public.get_psutil_disk_io_total() IS 'created for pgwatch2';
