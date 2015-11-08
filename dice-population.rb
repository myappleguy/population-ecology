require 'dicebag'
require 'spreadsheet'

generation = 1
population = 4
header = ['Generation',
          'Initial population  size  (N)',
          'Number of  births  (B)',
          'Number of  deaths  (D)',
          'Final population  size  (N + B - D)',
          'Change in population size  (Final - Initial)']

new_book = Spreadsheet::Workbook.new
new_book.create_worksheet name: 'population Worksheet'
new_book.worksheet(0).insert_row(0, header)

while population < 100
  births = 0
  deaths = 0

  population.times do
    roll = DiceBag::Roll.new('1d6')
    case roll.result().total
    when 1, 4
      births += 1
    when 6
      deaths += 1
    end
  end

  final_population = population + births - deaths
  population_delta = final_population - population
  row_data = [generation,
              population,
              births,
              deaths,
              final_population,
              population_delta]
  new_book.worksheet(0).insert_row(generation, row_data)
  population = final_population
  generation += 1
end

new_book.write('population.xls')
