java -jar apksigner.jar sign \
--ks test.jks \
--ks-pass pass:123456 \
--key-pass pass:123456 \
--out $1 \
  $2

