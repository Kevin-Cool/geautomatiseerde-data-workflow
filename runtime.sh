# 1 run get_data.sh
echo "Getting date from api"
bash get_data.sh
# 2 clean the new raw data
echo "Cleaning gatherd data"
bash clean_data.sh
# start the vevn for python
echo "Starting the venv"
. env\\Scripts\\activate
# 3 analyse data
echo "Analysing the data"
py analyse_data.py
# 4 create reports
echo "Generating reports"
py report_gen.py
# 5 auto update
git add .
git commit -m "automated update"
git push origin main